class MyJobsController < ApplicationController

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

  get "/myjobs/:job_site/:id/added" do
    if logged_in?
      @job = Job.find(params[:id])
      if !current_user.jobs.find do |job| 
        job[:position] == @job.position && job[:company] == @job.company
      end
        current_user.jobs << @job
      end
      @site = params[:job_site]
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
      if !!UserJob.find_by(job_id: @current_job.id, user_id: @user.id).applied
        @applied = true
      else
        @applied = false
      end
      @site = 'none'
      erb :'jobs/show'
    else
      redirect '/login'
    end
  end

  get "/myjobs/:id/delete" do
    if logged_in? && current_user.jobs.include?(Job.find(params[:id]))
      @current_job = Job.find(params[:id])
      current_user.jobs.delete(@current_job.id)
      @in_my_jobs = false
      @user = current_user
      @applied = false
      @site = 'none'
    else
      redirect '/login'
    end
    erb :'jobs/show'
  end

end