class FavoritesController < ApplicationController
  before_action :ensure_guest_user, only: [:create, :destroy]

  def create
    @item = Item.find(params[:item_id])
    favorite = current_user.favorites.new(item_id: @item.id)
    favorite.save
  end

  def destroy
    @item = Item.find(params[:item_id])
    favorite = current_user.favorites.find_by(item_id: @item.id)
    favorite.destroy
  end

  private

  def ensure_guest_user
    if current_user.name == "ゲスト"
      redirect_to user_path(current_user), notice: 'ブックマーク機能の使用はユーザー登録が必要です。'
    end
  end
end
