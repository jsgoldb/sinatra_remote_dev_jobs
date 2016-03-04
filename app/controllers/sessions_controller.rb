class SessionsController < ApplicationController

  get '/login' do
    erb :"sessions/login"
  end

  post '/sessions' do
    login(params[:email], params[:password])
    if logged_in?
      @logged_in = true
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

end