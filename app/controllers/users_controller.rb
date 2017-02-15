class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @tweets = @user.tweets
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    file = params[:user][:image]
    @user.set_image(file)

    if @user.save
      redirect_to @user, notice: 'ユーザーが保存されました'
    else
      render :new
    end
  end

  def update

    file = params[:user][:image]
    @user.set_image(file)
    if @user.update(user_params)
      redirect_to @user, notice: 'ユーザー情報が更新されました'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'ユーザーが削除されました'
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email)
    end
end
