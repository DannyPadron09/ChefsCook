class PostsController < ApplicationController

    get '/posts' do
        if logged_in?
            @posts = Post.all 
            erb :'posts/posts'
        end
    end

end