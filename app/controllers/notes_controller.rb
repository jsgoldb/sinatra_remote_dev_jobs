class NotesController < ApplicationController

  post '/user/notes/:job_id' do
    if logged_in? 
      @note = Note.create(content: params[:note])
      current_user.notes << @note
      @current_job = Job.find(params[:job_id])
      #@note.job = Job.find(params[:jobid])
      @current_job.notes << @note
      @user = current_user
      @notes = user_job_notes(@user.jobs)
      @in_my_jobs = true
      erb :'jobs/show'
    else 
      redirect '/login'
    end

  end

  get '/user/notes/:id/edit' do
    if logged_in? && current_user.notes.include?(Note.find(params[:id]))
      @note = Note.find(params[:id])
      erb :'notes/edit'
    else
      redirect '/'
    end
  end

  patch '/notes/:id' do 
    if logged_in? && current_user.notes.include?(Note.find(params[:id]))
      @note = Note.find(params[:id])
      @note.update(content: params[:note])
      redirect "/myjobs/#{@note.job.id}"
    else
      redirect '/'
    end
  end

  delete '/notes/:id/delete' do
    if logged_in? && current_user.notes.include?(Note.find(params[:id]))
      @note = Note.find(params[:id])
      @job = @note.job
      @note.destroy
      redirect "/myjobs/#{@job.id}"
    else
      redirect '/'
    end
  end

end