class User < ActiveRecord::Base
  has_many :jobs
  has_many :notes
  has_many :user_jobs
  has_many :jobs, through: :user_jobs
end