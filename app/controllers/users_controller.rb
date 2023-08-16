class UsersController < ApplicationController
    def show
        @user = User.find(current_user.id)
        @user = User.find(params[:id])
        @tweets = @user.tweets.page(params[:page]).per(10)
        @userrooms = User.find(params[:id]).rooms
        @rooms = Room.all


        
    end
end
