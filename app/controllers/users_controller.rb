class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  include ApplicationHelper

  def index
    @users = User.all
  end

  def show
    @notes = @user.notes
  end

  def edit
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

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email)
    end

    def correct_user
      user = User.find(params[:id])
      # if文をcurrent_user?ヘルパーを用いて書き換えてください
      if !current_user?(user)
        redirect_to root_path, alert: '許可されていないページです'
      end
    end
end