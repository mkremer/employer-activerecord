require "employer-activerecord/pipeline"
require "employer-activerecord/job"

describe Employer::ActiveRecord::Pipeline do
  let(:pipeline) { Employer::ActiveRecord::Pipeline.new }

  before(:each) do
    Employer::ActiveRecord::Job.destroy_all
  end

  describe "#enqueue" do
    it "saves the job hash to the database" do
      job_hash = {class: "TestJob", attributes: {shape: "Square", color: "Blue"}}
      job_id = pipeline.enqueue(job_hash)
      job = Employer::ActiveRecord::Job.find(job_id)
      job.should_not be_nil
      job.type.should eq("TestJob")
      job.properties.should eq({"shape" => "Square", "color" => "Blue"}.to_json)
    end
  end

  describe "#dequeue" do
    it "locks a job from the database and returns it as a job hash" do
      job = Employer::ActiveRecord::Job.create!(state: :free, type: "TestJob", properties: {shape: "Triangle", color: "Green"}.to_json)
      job_hash = {id: job.id, class: "TestJob", attributes: {"shape" => "Triangle", "color" => "Green"}}
      pipeline.dequeue.should eq(job_hash)
    end
  end

  describe "clear" do
    it "deletes all jobs" do
      Employer::ActiveRecord::Job.should_receive(:destroy_all)
      pipeline.clear
    end
  end

  describe "#complete" do
    it "deletes the job from the database" do
      job = Employer::ActiveRecord::Job.create!(state: :free, type: "TestJob", properties: {shape: "Triangle", color: "Green"}.to_json)
      pipeline.complete(job)
      Employer::ActiveRecord::Job.where(id: job.id).count.should eq(0)
    end
  end

  describe "#reset" do
    it "unlocks the job in the database" do
      job = Employer::ActiveRecord::Job.create!(state: :locked, type: "TestJob", properties: {shape: "Triangle", color: "Green"}.to_json)
      pipeline.reset(job)
      job.reload
      job.state.should eq("free")
    end
  end

  describe "#fail" do
    it "marks the job as failed in the database" do
      job = Employer::ActiveRecord::Job.create!(state: :locked, type: "TestJob", properties: {shape: "Triangle", color: "Green"}.to_json)
      pipeline.fail(job)
      job.reload
      job.state.should eq("failed")
    end
  end
end
