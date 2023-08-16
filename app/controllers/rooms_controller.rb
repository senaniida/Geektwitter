class RoomsController < ApplicationController
    before_action :authenticate_user!

    def index
        @rooms = Room.all
        @tweets = Tweet.all
    end

    def new
        @room = Room.new
    end

    def create
        room = Room.new(room_params)

        if room.save
            redirect_to :action => "index"
        else
            redirect_to :action => "new"
        end
    end

    def show
        @room = Room.find(params[:id])
        @users = User.all
        
        #ranking実装
        @roomtweets = Room.find(params[:id]).tweets
        @ranks = User.find(@roomtweets.group(:user_id).order('count(id) desc').pluck(:user_id))
    end
  
    private
      def room_params
        params.require(:room).permit(:name)
      end
end
