class LegoController < ApplicationController

    get '/legos/new' do
        if session[:user_id]
            erb :'/legos/new'
        else
            redirect '/'
        end
    end

    post '/legos/new' do
        name = params[:name]
        theme = params[:theme]
        num_of_pieces = params[:num_of_pieces].to_i
        lego = Lego.new(name: name, theme: theme, num_of_pieces: num_of_pieces)

        if lego.save
            user = User.find_by_id(session[:user_id])
            user.legos << lego
            redirect "/legos/#{lego.id}"
        else
            redirect '/legos/new'
        end

    end

    get '/legos/:id' do
        @user = User.find_by_id(session[:user_id])
        @lego = Lego.find_by_id(params[:id])
        if @lego
            erb :'/legos/show'
        else
            redirect '/legos/new'
        end
    end

    get '/legos/:id/edit' do
        if session[:user_id]
            user = User.find_by_id(session[:user_id])
            @lego = Lego.find_by_id(params[:id])
            if @lego.user_id == user.id
                erb :'/legos/edit'
            else
                redirect '/user'
            end
        else
            redirect '/login'
        end
    end

    patch '/legos/:id' do
        binding.pry
        @lego = Lego.find_by_id(params[:id])
        params.delete("_method")
        if @lego.update(params)
            redirect "/legos/#{@lego.id}"
        else
            redirect "/legos/#{@lego.id}/edit"
        end
    end
end