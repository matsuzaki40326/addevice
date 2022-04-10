class GoodsController < ApplicationController
  def create
    review = Review.find(params[:item_id])
    good = current_user.goods.create(review_id: review.id)
    redirect_to request.referer
  end

  def destroy
    review = Review.find(params[:item_id])
    good = current_user.goods.find_by(review_id: review.id)
    good.destroy
    redirect_to request.referer
  end
end
