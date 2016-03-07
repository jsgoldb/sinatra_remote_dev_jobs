class RemoveDescritionAddDescriptionColumnToJobs < ActiveRecord::Migration
  def change
    remove_column :jobs, :descrition
    add_column :jobs, :description, :string 
  end

end
