require "employer-activerecord/version"
require "employer-activerecord/job"
require "employer-activerecord/pipeline"
require "employer/employees/forking_employee"

Employer::Employees::ForkingEmployee.before_fork { ::ActiveRecord::Base.establish_connection }
