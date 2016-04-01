class User < ActiveRecord::Base
  has_many :jobs
  has_many :notes
  has_many :user_jobs
  has_many :jobs, through: :user_jobs

  has_secure_password

  validates :email, presence: true, uniqueness: true

end