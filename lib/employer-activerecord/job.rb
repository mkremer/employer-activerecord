require "active_record"

module Employer
  module ActiveRecord
    class Job < ::ActiveRecord::Base
      self.table_name = "employer_jobs"
      self.inheritance_column = "_type"

      validates :state, presence: true
      validates :type, presence: true

      scope :free, where(state: :free)
    end
  end
end
