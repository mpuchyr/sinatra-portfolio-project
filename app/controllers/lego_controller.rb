class LegoController < ApplicationController



    get '/legos/new' do
        if session[:user_id]
            if session[:errors]
                @errors = session[:errors]
                session.delete(:errors)
            end
            erb :'/legos/new'
        else
            redirect '/'
        end
    end

    post '/legos/new' do
        name = params[:name]
        num_of_pieces = params[:num_of_pieces].to_i
        img_link = params[:img_link]
        lego = Lego.new(name: name, num_of_pieces: num_of_pieces, img_link: img_link)

        if lego.save
            if params[:new_theme] != ""
                theme = Theme.find_or_create_by(name: params[:new_theme])
            elsif params[:theme]
                theme = Theme.find_or_create_by(name: params[:theme])
            end
            theme.legos << lego
            current_user.legos << lego
            redirect '/user'
        else
            session[:errors] = lego.errors.full_messages
            redirect '/legos/new'
        end

    end

    get '/legos/all' do
        erb :'/legos/all'
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
            @lego = Lego.find_by_id(params[:id])
            if @lego.user_id == current_user.id
                erb :'/legos/edit'
            else
                redirect '/user'
            end
        else
            redirect '/login'
        end
    end

    patch '/legos/:id' do
        @lego = Lego.find_by_id(params[:id])
        name = params[:name]
        if params[:new_theme] != ""
            theme = Theme.find_or_create_by(name: params[:new_theme])
        elsif params[:theme]
            theme = Theme.find_or_create_by(name: params[:theme])
        end
        pieces = params[:num_of_pieces]
        img = params[:img_link]
        params.delete("_method")
        if @lego.update(name: name, num_of_pieces: pieces, img_link: img)
            theme.legos << @lego
            redirect "/legos/#{@lego.id}"
        else
            redirect "/legos/#{@lego.id}/edit"
        end
    end

    delete '/legos/:id' do
        @lego = Lego.find_by_id(params[:id])
        if @lego.user.id == current_user.id
            @lego.delete
            redirect '/user'
        else
            redirect '/user'
        end
    end


end