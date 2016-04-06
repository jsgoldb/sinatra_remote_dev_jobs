ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
require 'open-uri'

#Bundler.require(:default, ENV['SINATRA_ENV'])
Bundler.require(:default, "production")

# ActiveRecord::Base.establish_connection(
#   :adapter => "sqlite3",
#   :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
#   )

# configure :development do
#   #set :database, 'sqlite://development.db'
#  ActiveRecord::Base.establish_connection(
#   :adapter => "sqlite3",
#   :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
#    )
# end
 
configure :development, :production do
  # Database connection
  db = URI.parse('postgres://vmvgmkysmutfzy:pDbknEq3pkMShcbQA0UQ_pqA_s@ec2-54-227-250-148.compute-1.amazonaws.com:5432/d8g8c036fg85fr' || 'postgres://localhost/mydb')
 
  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
end

require_all 'app'