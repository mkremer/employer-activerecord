require "pry"
require "active_record"
require "generators/employer/templates/migration"

# Connect with an in-memory SQLite database
ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

# Run the template migration to generate the jobs table
CreateEmployerJobs.new.change
