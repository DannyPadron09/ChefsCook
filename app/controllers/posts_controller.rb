class PostsController < ApplicationController

    get '/posts' do
        if logged_in?
            @posts = Post.all 
            erb :'posts/posts'
        end
    end

    get '/posts/new' do
        if logged_in?
            erb :'posts/new'
        else
            redirect to '/login'
        end
    end

    post '/posts' do
        if logged_in?
            if params[:title] == "" || params[:content] == ""
                redirect to '/posts/new'
            else
                @post = current_user.posts.new(title: params[:title], content: params[:content])
                if @post.save
                    redirect to "/posts/#{@post.id}"
                else
                    redirect to "/posts/new"
                end
            end
        else
            redirect to '/login'
        end
    end

    get '/posts/:id' do
        if logged_in?
            @post = Post.find_by_id(params[:id])
            erb :'posts/show_post'
        else
            redirect to '/login'
        end
    end

    get '/posts/:id/edit' do
        if logged_in?
            @post = Post.find_by_id(params[:id])
            if @post && @post.user_id == current_user.id 
                erb :'posts/edit_post'
            else
                redirect to '/posts'
            end
        else
            redirect to '/login'
        end
    end

    patch '/posts/:id' do
        if logged_in?
            if params[:title] == "" || params[:content] == ""
                redirect to '/posts/new'
            else
                @post = Post.find_by_id(params[:id])
                @post.title = params[:title]
                @post.content = params[:content]
                @post.save
                redirect to "/posts/#{@post.id}"
            end
        end
    end

    delete '/posts/:id' do
        if logged_in?
            @post = Post.find_by_id(params[:id])
            if @post && @post.user_id == current_user.id
                @post.delete 
            end
            redirect to '/posts'
        else
            redirect to '/login'
        end
    end
end