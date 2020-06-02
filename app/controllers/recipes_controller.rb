class RecipesController < ApplicationController

    get '/recipes' do
        if logged_in?
            @recipe = Recipe.all 
            erb :'recipes/recipes'
        else
            redirect to '/login'
        end
    end

    get '/recipes/new' do
        if logged_in?
            erb :'recipes/new'
        else
            redirect to '/login'
        end
    end

    post '/recipes' do
        if logged_in?
            if params[:recipe_name] == "" || params[:recipe_ingredients] == ""
                redirect to '/recipes/new'
            else
                @recipe = current_user.recipes.build(name: params[:recipe_name], ingredients: params[:recipe_ingredients])
                if @recipe.save
                    redirect to "/recipes/#{@recipe.id}"
                else
                    redirect to '/recipes/new'
                end
            end
        else
            redirect to '/login'
        end
    end

    get '/recipes/:id' do
        if logged_in?
            @recipe = Recipe.find_by_id(params[:id])
            erb :'recipes/show_recipe'
        else
            redirect to '/login'
        end
    end

    get '/recipes/:id/edit' do
        if logged_in?
            @recipe = Recipe.find_by_id(params[:id])
            if @recipe && @recipe.user_id == current_user.id 
                erb :'recipes/edit_recipe'
            else
                redirect to '/recipes'
            end
        else
            redirect to '/login'
        end
    end

    patch '/recipes/:id' do
        if logged_in?
            if params[:recipe_name] == "" || params[:recipe_ingredients] == "" 
                redirect to '/recipes/new'
            else
                @recipe = Recipe.find_by_id(params[:id])
                @recipe.name = params[:recipe_name]
                @recipe.ingredients = params[:recipe_ingredients]
                @recipe.save
                redirect to "/recipes/#{@recipe.id}"
            end
        end
    end

    delete '/recipes/:id' do
        if logged_in?
            @recipe = Recipe.find_by_id(params[:id])
            if @recipe && @recipe.user_id == current_user.id
                @recipe.delete
                redirect to '/recipes'
            else
                redirect to '/recipes'
            end
        else
            redirect to '/login'
        end
    end

end