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

    get '/posts/:id' do
        if logged_in?
            @post = Post.find_by_id(params[:id])
            erb :'posts/show_post'
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

    post '/posts' do
        @post = Post.create(params)
        redirect to "posts/#{@post.id}"
    end
    # post '/posts/new' do
        # if logged_in?
            # if params[:title] == "" || params[:content] == ""
                # redirect to '/posts/new'
            # else
                # @post = current_user.posts.build(tile: params[:title], content: params[:content])
                # if @post.save
                    # redirect to "/posts/#{@post.id}"
                # else
                    # redirect to "/posts/news"
                # end
            # end
        # else
            # redirect to '/login'
        # end
    # end
    
 

end