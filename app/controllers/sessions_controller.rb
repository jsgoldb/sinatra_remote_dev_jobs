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





end