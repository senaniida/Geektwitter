class TweetsController < ApplicationController

    before_action :authenticate_user!

    def index
        require "date"
 
        @date = Date.today
        if params[:search] == nil
            @tweets= Tweet.all.page(params[:page]).per(8)
        elsif params[:search] == ''
            @tweets= Tweet.all.page(params[:page]).per(8)
        else
            #@tweets= Tweet.where("body LIKE ? ",'%' + params[:search] + '%').page(params[:page]).per(3)
            search = params[:search].to_s
            @tweets= Tweet.where("body LIKE ? ",'%' + search + '%').page(params[:page]).per(3)
        end

        #タグ検索実装
        @tagsearch = []
        if params[:tag_ids] == nil
            @tagId = [["選択されていません","1"]]
        else
            @tagId = params[:tag_ids]
        end

        if params[:tag_ids]
            @tagsearch = []
            params[:tag_ids].each do |key, value|      
                @tagsearch += Tag.find_by(name: key).tweets if value == "1"
            end
            @tagsearch.uniq!
        end

        #いいねランキング実装
        @all_ranks = Tweet.find(Like.group(:tweet_id).order('count(tweet_id) desc').limit(3).pluck(:tweet_id))

        #金額計算機能
        @total = params[:cut].to_f + params[:color].to_f + params[:perm].to_f + params[:radio].to_f

        #submitで切り替えできるか
        #@tweets = Tweet.where("body LIKE ? ",'%' + params[:tab] + '%')

        #URL取得
        @url = request.url
        #コントローラー名取得
        @controller = controller_name
        #@sample = @tweets.first(2..3)
        @sample = @tweets[3]
    end
    #userへ飛ばしたい！
    def touser
        tweet = Tweet.find(params[:tweet])
        user = tweet.user
        redirect_to  controller: :users, action: :show, id: user.id
    end

    #スクレイピング
    def scraping
        agent = Mechanize.new
        page = agent.get("https://radwimps.jp/")
        @elements = page.search('img')

        play = Mechanize.new
        page2 = play.get("https://hanshintigers.jp/data/player/2023/")
        @players = page2.search('dt>a')
    end

    def new
        @newtweet = Tweet.new

        
        rooms = [["roomを選択", 0]]
        Room.all.each do |r|
            room = []
            room.push(r.name)
            room.push(r.id)
            rooms.push(room)
        end
        @rooms = rooms
        @taggenre = Tag.select(:genre).distinct
    end


    def create
        tweet = Tweet.new(tweet_params)

        tweet.user_id = current_user.id

        if tweet.save
            redirect_to  controller: :rooms, action: :show, id: tweet.room_id
        else
            redirect_to :action => "new"
        end
    end


    def show
        @tweet = Tweet.find(params[:id])
        @makky = "apple"
        @comments = @tweet.comments
        @comment = Comment.new


        tag_names = []
        @tweet.tags.each do |tag|
            tag_names.push(tag.name)
        end

        @tagsearch = []
        if tag_names
            tag_names.each do |tname|      
                @tagsearch += Tag.find_by(name: tname).tweets
            end
            @tagsearch.uniq!
        end
    end

    def edit
        @tweet = Tweet.find(params[:id])
        @tagsearch = []
    end

    def update
        tweet = Tweet.find(params[:id])
        if tweet.update(tweet_params)
            redirect_to :action => "show", :id => tweet.id
        else
            redirect_to :action => "new"
        end
    end

    def destroy
        tweet = Tweet.find(params[:id])
        tweet.destroy
        redirect_to :action => "index"
    end

    private
    def tweet_params
        params.require(:tweet).permit(:body, :image, :overall, :level, :room_id, :video, tag_ids: [])
    end

end