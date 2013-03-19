require "json"

module Employer
  module ActiveRecord
    class Pipeline
      def enqueue(job_hash)
        job_attributes = {
          type: job_hash[:class],
          properties: job_hash[:attributes].to_json,
          state: :free
        }

        Employer::ActiveRecord::Job.create!(job_attributes).id
      end

      def dequeue
        if job = Employer::ActiveRecord::Job.free.order("created_at ASC").lock(true).first
          job.state = :locked
          job.save!
          {id: job.id, class: job.type, attributes: JSON.parse(job.properties)}
        end
      end

      def clear
        Employer::ActiveRecord::Job.destroy_all
      end

      def complete(job)
        Employer::ActiveRecord::Job.find(job.id, lock: true).destroy
      end

      def fail(job)
        Employer::ActiveRecord::Job.find(job.id, lock: true).update_attributes(state: :failed)
      end

      def reset(job)
        Employer::ActiveRecord::Job.find(job.id, lock: true).update_attributes(state: :free)
      end
    end
  end
end
