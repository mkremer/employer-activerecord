require 'rails/generators/active_record'

module Employer
  class ActiveRecordGenerator < ::Rails::Generators::Base
    include Rails::Generators::Migration
    extend ActiveRecord::Generators::Migration

    source_paths << File.join(File.dirname(__FILE__), "templates")

    def create_migration_file
      migration_template 'migration.rb', 'db/migrate/create_employer_jobs.rb'
    end
  end
end
