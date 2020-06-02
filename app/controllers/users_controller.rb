class UsersController < ApplicationController

    get '/signup' do 
        if !logged_in?
            erb :'users/create_user'
        else
            redirect to '/'
        end
    end

    post '/signup' do
        if params[:name] == "" || params[:password] == "" || params[:restaurant] == "" 
            redirect to '/signup'
        else
            @user = User.new(:name => params[:name], :password => params[:password], :restaurant => params[:restaurant])
            @user.save
            session[:user_id] = @user.id 
            redirect to '/posts'
        end
    end

    get '/login' do
        if !logged_in?
            erb :'users/login'
        else
            redirect to '/posts'
        end
    end

    post '/login' do
        user = User.find_by(:name => params[:name])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to '/posts'
        else
            redirect to '/signup'
        end
    end

    get '/logout' do 
        if logged_in?
            session.destroy
            redirect to '/'
        else
            redirect to '/'
        end
    end

end