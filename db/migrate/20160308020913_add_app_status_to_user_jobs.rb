class AddAppStatusToUserJobs < ActiveRecord::Migration
  def change
    add_column :user_jobs, :applied, :boolean
  end
end
