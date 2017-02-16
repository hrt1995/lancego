class TweetsController < ApplicationController

before_action :set_tweet, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user!

  def index
    @tweets = Tweet.all
  end

  def show
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if
      @tweet.save
      redirect_to @tweet, notice: '投稿が完了しました！'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if
      @tweet.update(tweet_params)
      redirect_to @tweet, notice: "投稿が更新されました！"
    else
      render :edit
    end
  end

  def destroy
    @tweet.destroy
    redirect_to tweets_path
  end

  private
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

  private
    def tweet_params
      params.require(:tweet).permit(:content, :user_id)
    end

end
