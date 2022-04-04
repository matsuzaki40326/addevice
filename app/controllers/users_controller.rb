class UsersController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end

  def update

  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:item_id)
    @favorite_items = Item.find(favorites)
  end
end
