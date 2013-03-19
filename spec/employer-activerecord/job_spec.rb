require "employer-activerecord/job"

describe Employer::ActiveRecord::Job do
  let(:job) { Employer::ActiveRecord::Job.new(state: :free, type: "TestJob") }

  it "requires state" do
    job.state = nil
    job.should be_invalid
    job.errors.should include(:state)
    job.state = :free
    job.should be_valid
  end

  it "requires type" do
    job.type = nil
    job.should be_invalid
    job.errors.should include(:type)
    job.type = "TestJob"
    job.should be_valid
  end

  describe ".free" do
    it "returns jobs with state free" do
      job1 = Employer::ActiveRecord::Job.create(state: :free, type: "TestJob")
      job2 = Employer::ActiveRecord::Job.create(state: :free, type: "TestJob")
      job3 = Employer::ActiveRecord::Job.create(state: :locked, type: "TestJob")

      free_jobs = Employer::ActiveRecord::Job.free.to_a
      free_jobs.should include(job1)
      free_jobs.should include(job2)
      free_jobs.should_not include(job3)
    end
  end
end
