class UsersController < ApplicationController
  
  get '/signup' do 
    erb :'users/new'
  end

  post '/users' do 
    @user = User.new
    @user.username = params[:username]
    @user.password = params[:password]
    if @user.save
      @new_user = true
      erb :'sessions/login'
    else
      erb :'users/new'
    end
  end


end