class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :job

  validates :content, presence: true
end