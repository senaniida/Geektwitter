class KeepsController < ApplicationController
    def create
        keep = current_user.keeps.create(tweet_id: params[:tweet_id]) #user_idとtweet_idの二つを代入
        redirect_back(fallback_location: root_path)
      end
    
      def destroy
        keep = Keep.find_by(tweet_id: params[:tweet_id], user_id: current_user.id)
        keep.destroy
        redirect_back(fallback_location: root_path)
      end
end