class CreateEmployerJobs < ActiveRecord::Migration
  def change
    create_table :employer_jobs do |t|
      t.string :state
      t.string :type
      t.text :properties

      t.timestamps
    end

    add_index :employer_jobs, [:state, :created_at], order: {created_at: :asc}
  end
end
