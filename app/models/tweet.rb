class Tweet < ApplicationRecord

    belongs_to :user
    belongs_to :room, optional: true

    mount_uploader :image, ImageUploader

    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user

    has_many :comments, dependent: :destroy
    has_many :keeps, dependent: :destroy
    has_many :kept_users, through: :keeps, source: :user
    
    #tweetsテーブルから中間テーブルに対する関連付け
    has_many :tweet_tag_relations, dependent: :destroy
    #tweetsテーブルから中間テーブルを介してTagsテーブルへの関連付け
    has_many :tags, through: :tweet_tag_relations, dependent: :destroy
    
    #動画投稿機能
    mount_uploader :video, VideoUploader
end
