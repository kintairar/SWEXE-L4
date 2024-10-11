class TopController < ApplicationController
    def main
        if session[:login_uid]
            render 'main'
        else
            render 'login'
        end
    end
  
    def login
        user = User.find_by(uid: params[:uid])
        if user
            if BCrypt::Password.new(user.pass) == params[:pass]
                session[:login_uid] = params[:uid]
                redirect_to top_main_path
            else 
                render 'error', status: 422
            end
        else
            render 'error', status: 422
        end
    end
    
    def logout
        session.delete(:login_uid)
        redirect_to root_path
    end
    
    def signup
        @user = User.new
    end
    
    def register
        uid = params[:user][:uid]
        pass = BCrypt::Password.create(params[:user][:pass])
        @user = User.new(uid: uid, pass: pass)
        if @user.save
            redirect_to '/'
        else
            render 'signup', status: :unprocessable_entity
        end
    end
end