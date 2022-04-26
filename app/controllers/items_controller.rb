class ItemsController < ApplicationController
  before_action :only_admin, except: [:index, :show]

  def new
    @item = Item.new
    @category = Category.new
    @categories = Category.all
    @maker = Maker.new
    @makers = Maker.all
  end

  def create
    item = Item.new(item_params)
    if item.save
      redirect_to request.referer, notice: "追加しました。"
    else
      redirect_to request.referer, alert: "追加に失敗しました。"
    end
  end

  def index
    if Rails.env.development? || Rails.env.test?
      @items = Item.order("RANDOM()").limit(12)
    else
      @items = Item.order("RAND()").limit(12)
    end
  end

  def show
    @item = Item.find(params[:id])
    @review = Review.new
    item_reviews = Review.where(item_id: @item.id)
    @review_count = item_reviews.count
    @average = item_reviews.average(:rate)
    if params[:rate] == "1"
      item_reviews = Review.where(item_id: @item.id, rate: 1)
      @reviews = Kaminari.paginate_array(item_reviews).page(params[:page]).per(20)
    elsif params[:rate] == "2"
      item_reviews = Review.where(item_id: @item.id, rate: 2)
      @reviews = Kaminari.paginate_array(item_reviews).page(params[:page]).per(20)
    elsif params[:rate] == "3"
      item_reviews = Review.where(item_id: @item.id, rate: 3)
      @reviews = Kaminari.paginate_array(item_reviews).page(params[:page]).per(20)
    elsif params[:rate] == "4"
      item_reviews = Review.where(item_id: @item.id, rate: 4)
      @reviews = Kaminari.paginate_array(item_reviews).page(params[:page]).per(20)
    elsif params[:rate] == "5"
      item_reviews = Review.where(item_id: @item.id, rate: 5)
      @reviews = Kaminari.paginate_array(item_reviews).page(params[:page]).per(20)
    else
      @reviews = Kaminari.paginate_array(item_reviews).page(params[:page]).per(20)
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to item_path(item), notice: "変更しました。"
    else
      redirect_to request.referer, alert: "変更に失敗しました。"
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to items_path, notice: "削除しました。"
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :category_id, :maker_id)
  end

  def only_admin
    unless current_user.admin
      redirect_to user_path(current_user)
    end
  end

  def item_search_params
    params.fetch(:search, {}).permit(:category_id, :maker_id, category_ids: [], maker_ids: [])
  end

end
