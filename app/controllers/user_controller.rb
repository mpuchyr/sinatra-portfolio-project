class UserController < ApplicationController
    get '/signup' do
        if session[:errors]
          @errors = session[:errors]
          session.delete(:errors)
        end
        if !logged_in?
          erb :signup
        else
          redirect '/'
        end
      end
    
      post '/signup' do
        user = User.new(params)
        if user.save
          redirect :login
        else
          session[:errors] = user.errors.full_messages
          redirect '/signup'
        end
      end
    
      get '/login' do
        if session[:errors]
          @errors = session[:errors]
          session.delete(:errors)
        end
        if !logged_in?
          erb :login
        else
          redirect '/'
        end
      end
    
      post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect '/user'
        else
          session[:errors] = ["Username or password was incorrect. Please try again."]
          redirect '/login'
        end
      end
    
      get '/user' do
        if logged_in?
          @user = User.find_by(id: session[:user_id])
          erb :'/users/home'
        else
          redirect '/'
        end
      end
    
      get '/logout' do
        if logged_in?
          session.clear
        end
        redirect '/'
      end
end