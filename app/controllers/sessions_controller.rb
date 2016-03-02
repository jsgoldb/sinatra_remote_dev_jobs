class SessionsController < ApplicationController

  get '/login' do
    erb :"sessions/login"
  end

  post '/sessions' do
    login(params[:email])
    redirect '/'
  end

  get '/logout' do
    logout
    redirect '/'
  end

end