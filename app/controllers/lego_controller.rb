class LegoController < ApplicationController

    get '/legos/new' do
        erb :'/legos/new'
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
        @lego = Lego.find_by_id(params[:id])
        binding.pry
        if @lego
            erb :'/legos/show'
        else
            redirect '/legos/new'
        end
    end
end