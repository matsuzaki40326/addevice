class ReviewsController < ApplicationController
  before_action :authenticate_user!
  def create
    @item = Item.find(params[:item_id])
    @review = current_user.reviews.new(review_params)
    @review.item_id = @item.id
    if @review.save
      flash[:notice] = "レビューを投稿しました。"
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    review = Review.find(params[:item_id])
    review.destroy
    redirect_to item_path(review.item)
  end

  def edit
    @review = Review.find(params[:item_id])
  end

  def update
    review = Review.find(params[:item_id])
    if review.update(review_params)
      flash[:notice] = "レビューを編集しました。"
      redirect_to request.referer
    else
      @review = Review.find(params[:id])
      render 'edit'
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rate)
  end
end
