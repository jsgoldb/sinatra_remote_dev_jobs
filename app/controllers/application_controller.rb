require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "sinatra_remote_dev_jobs"
  end

  get '/' do
    "You are logged in as #{session[:email]}"
  end

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end

    def login(email)
      session[:email] = params[:email]
    end

    def logout
      session.clear
    end
  end

end