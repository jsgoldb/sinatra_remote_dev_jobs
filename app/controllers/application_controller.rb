require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "sinatra_remote_dev_jobs"
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(email: session[:email]) if session[:email]
    end

    def login(email, password)
      user = User.find_by(email: email) 
      if user && user.authenticate(password)
        session[:email] = user.email
      end
    end

    def logout
      session.clear
    end

    def user_job_notes(jobs)
      Note.all.map do |note|
        note if note.user_id == current_user.id && note.job_id == @current_job.id
      end
    end
  end

end