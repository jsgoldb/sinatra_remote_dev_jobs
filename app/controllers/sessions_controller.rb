class SessionsController < ApplicationController

  get '/login' do
    erb :"sessions/login"
  end

  post '/sessions' do
    login(params[:email], params[:password])
    if logged_in?
      erb :"sessions/index"
    else
      @failure = true
      erb :'sessions/login'
    end
  end

  get '/logout' do
    logout
    redirect '/'
  end

  get '/search' do
    erb :'sessions/index'
  end

  get "/users/myjobs" do
    if logged_in?
      @user = User.find_by(email: current_user.email)
      @notes = Note.all.map do |note|
        note if (note.user_id == current_user.id)
      end.compact
      erb :'users/jobs'
    else
      redirect '/login'
    end
  end

  get "/myjobs/:id/added" do
    if logged_in?
      @job = Job.find(params[:id])
      if !current_user.jobs.find do |job| 
        job[:position] == @job.position && job[:company] == @job.company
      end
        current_user.jobs << @job
      end
      @user = current_user 
      @added = true
      @notes = Note.all.map do |note|
        note if (note.user_id == current_user.id)
      end.compact
      erb :'users/jobs'
    else
      redirect '/login'
    end
  end

  get "/myjobs/:id" do 
    if logged_in? && current_user.jobs.include?(Job.find(params[:id]))
      @in_my_jobs = true
      @current_job = Job.find(params[:id])
      @user = current_user
      @notes = user_job_notes(@current_job)
      erb :'jobs/show'
    else
      redirect '/login'
    end
  end

end