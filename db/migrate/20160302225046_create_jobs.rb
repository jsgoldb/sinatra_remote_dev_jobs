class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :company
      t.string :location
      t.string :position
      t.string :descrition
      t.string :job_url
      t.string :seniority
      t.string :company_site
    end
  end
end
