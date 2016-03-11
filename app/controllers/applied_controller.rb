class AppliedController < ApplicationController
  
  get '/myjobs/:id/applied' do
    @job = Job.find(params[:id])
    current_user.jobs << @job if !current_user.jobs.include?(@job)
    if logged_in? && current_user.jobs.include?(@job)
      user_job_pair = UserJob.find_by(job_id: @job.id, user_id: current_user.id)
      user_job_pair.applied = true
      user_job_pair.save
      redirect "/myjobs/#{@job.id}"
    else
      redirect "/login"
    end
  end

  get '/myjobs/applied' do
    if logged_in?
      @user = current_user
      user_job_pairs = UserJob.all.map do |pair|
        pair if (@user.id == pair.user_id && pair.applied == true)
      end.compact
      if !user_job_pairs.empty?
        @jobs = user_job_pairs.map do |pair|
          Job.find(pair.job_id)
        end
      else
        @none_applied_for = true
      end
      erb :'users/applied'
    else
      redirect "/login"
    end
  end

  get '/myjobs/applied/:id/remove' do
    if logged_in? 
      pair = UserJob.find_by(job_id: params[:id], user_id: current_user.id)
      pair.applied = false
      pair.save
      redirect "/myjobs/#{params[:id]}"
    else
      redirect '/login'
    end
  end

end