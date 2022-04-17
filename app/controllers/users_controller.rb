class UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit, :withdrawal]
  before_action :ensure_user, only: [:edit, :update]
  def index
    @users = User.page(params[:page]).per(20)
  end

  def show
    @user = User.find(params[:id])
    reviews = Review.where(user_id: @user)
    @reviews = Kaminari.paginate_array(reviews).page(params[:page]).per(7)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
       flash[:notice] = "プロフィールを編集しました。"
       redirect_to user_path(user)
    else
       user = User.find(params[:id])
       render 'edit'
    end
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:item_id)
    @favorite_items = Item.find(favorites)
  end

  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました。"
    redirect_to root_path
  end

  def search
    @users = User.looks(params[:search], params[:word])
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(20)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :is_deleted)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "ゲスト"
      redirect_to user_path(current_user), notice: 'ブックマーク機能の使用はユーザー登録が必要です。'
    end
  end

  def ensure_user
    @user = User.find(params[:id])
    unless (@user == current_user) || current_user.admin?
      redirect_to user_path(current_user)
    end
  end
end
