class TweetsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    # if params[:tag_id].present?
    #     @tweets = Tag.find(params[:tag_id]).tweets.page(params[:page]).per(3)
    # elsif params[:search] == nil
    #     @tweets= Tweet.all.page(params[:page]).per(3)
    # elsif params[:search] == ''
    #     @tweets= Tweet.all.page(params[:page]).per(3)
    # else
    #     #部分検索
    #     @tweets = Tweet.where("body LIKE ? ",'%' + params[:search] + '%').page(params[:page]).per(3)
    # end
    # @tweets = params[:tag_id].present? ? Tag.find(params[:tag_id]).tweets.page(params[:page]).per(3) : Tweet.all.page(params[:page]).per(3)



    # @tweets= Tweet.all.page(params[:page]).per(3)
    # @tags = Tag.all.page(params[:page]).per(3)
    # @tweets = @tweets.where("body LIKE ? ",'%' + params[:search] + '%') if params[:search].present?
    # もしタグ検索したら、tweet_idsにタグを持ったidをまとめてそのidで検索
    # if params[:tag_ids].present?
      # tweet_ids = []
      # params[:tag_ids].each do |key, value|
        # if value == "1"
          # Tag.find_by(name: key).tweets.each do |p|
            # tweet_ids << p.id
          # end
        # end
      # end
      # tweet_ids = tweet_ids.uniq
      # キーワードとタグのAND検索
      # @tweets = @tweets.where(id: tweet_ids).page(params[:page]).per(3) if tweet_ids.present?
    # end

    if params[:search].blank? && params[:tag_id].blank?
      @tweets= Tweet.all.order(created_at: :desc).page(params[:page]).per(6)
    elsif params[:search].present? && params[:tag_id].blank?
      @tweets= Tweet.order(created_at: :desc).where("body LIKE ? OR title LIKE ? OR language LIKE ?",'%' + params[:search] + '%','%' + params[:search] + '%','%' + params[:search] + '%').page(params[:page]).per(6)
    elsif params[:search].blank? && params[:tag_id].present?
      @tweets = Tag.find(params[:tag_id]).tweets.order(created_at: :desc).page(params[:page]).per(6)
    else
      @tweets = Tag.find(params[:tag_id]).tweets.order(created_at: :desc).where("body LIKE ? OR title LIKE ? OR language LIKE ?",'%' + params[:search] + '%','%' + params[:search] + '%','%' + params[:search] + '%').page(params[:page]).per(6)
    end


  end

  def new
    @tweet = Tweet.new
  end

  def create
    tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id
    if tweet.save
      redirect_to :action =>"index"
    else
      redirect_to :action => "new"
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments
    @comment = Comment.new
  end

  def edit
        @tweet = Tweet.find(params[:id])
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
    redirect_to user_path(current_user.id)
  end

  private
    def tweet_params
      params.require(:tweet).permit(:body, :image, :title, :language,:tweet_url, tag_ids: [])
    end
    # def article_params
    #   params.require(:article).permit(:body, tag_ids: [])
    # end
  end
