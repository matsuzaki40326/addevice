class GoodsController < ApplicationController
  before_action :ensure_guest_user, only: [:create,:destroy]

  def create
    @review = Review.find(params[:item_id])
    good = current_user.goods.create(review_id: @review.id)
  end

  def destroy
    @review = Review.find(params[:item_id])
    good = current_user.goods.find_by(review_id: @review.id)
    good.destroy
  end

  private

  def ensure_guest_user
    if current_user.name == "ゲスト"
      redirect_to user_path(current_user), notice: '高評価機能の使用はユーザー登録が必要です。'
    end
  end
end
