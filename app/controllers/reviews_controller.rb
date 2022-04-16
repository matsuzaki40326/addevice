class ReviewsController < ApplicationController
  before_action :ensure_guest_user
  def create
    @item = Item.find(params[:item_id])
    review = current_user.reviews.new(review_params)
    review.item_id = @item.id
    @test = 'test'
    if review.save
      @reviews = Review.where(item_id: @item.id)
      @average = @reviews.average(:rate)
      @reviews = Kaminari.paginate_array(@reviews).page(params[:page]).per(5)
      flash[:notice] = "レビューを投稿しました。"
    else
      redirect_to request.referer
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to item_path(review.item)
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    if review.update(review_params)
      flash[:notice] = "レビューを編集しました。"
      redirect_to item_path(review.item)
    else
      @review = Review.find(params[:id])
      render 'edit'
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rate)
  end

  def ensure_guest_user
    if current_user.name == "ゲスト"
      redirect_to user_path(current_user), notice: 'レビュー機能の使用はユーザー登録が必要です。'
    end
  end
end
