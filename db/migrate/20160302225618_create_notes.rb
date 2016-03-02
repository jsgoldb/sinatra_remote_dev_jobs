class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :job_id
      t.integer :user_id
      t.string :content
    end
  end
end
