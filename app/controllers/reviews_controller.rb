class ReviewsController < ApplicationController
  before_action :ensure_guest_user
  def create
    @item = Item.find(params[:item_id])
    review = current_user.reviews.new(review_params)
    review.item_id = @item.id
    @review_count = Review.where(item_id: @item.id).count
    review_count = Review.where(item_id: params[:item_id]).where(user_id: current_user.id).count
    if review.valid?
      if review_count < 1
       review.save
       @reviews = Review.where(item_id: @item.id)
       @average = @reviews.average(:rate)
       @reviews = Kaminari.paginate_array(@reviews).page(params[:page]).per(10)
       flash[:notice] = "レビューを投稿しました。"
       redirect_to request.referer
      else
        redirect_to request.referer, alert: "レビューの投稿は1度までです。"
      end
    else
      redirect_to request.referer, alert: "投稿に失敗しました。"
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
      redirect_to request.referer, alert: "編集に失敗しました。"
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rate)
  end

  def ensure_guest_user
    if current_user.name == "ゲスト"
      redirect_to user_path(current_user), alert: 'レビュー機能の使用はユーザー登録が必要です。'
    end
  end
end
