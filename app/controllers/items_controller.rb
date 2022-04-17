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
    item.save
    redirect_to request.referer
  end

  def index
    @items = Item.page(params[:page]).per(5)
  end

  def show
    @item = Item.find(params[:id])
    @review = Review.new
    @reviews = Review.where(item_id: @item.id)
    @average = @reviews.average(:rate)
    if params[:rate] == "1"
      @reviews = Review.where(item_id: @item.id, rate: 1)
      @reviews = Kaminari.paginate_array(@reviews).page(params[:page]).per(10)
    elsif params[:rate] == "2"
      @reviews = Review.where(item_id: @item.id, rate: 2)
      @reviews = Kaminari.paginate_array(@reviews).page(params[:page]).per(10)
    elsif params[:rate] == "3"
      @reviews = Review.where(item_id: @item.id, rate: 3)
      @reviews = Kaminari.paginate_array(@reviews).page(params[:page]).per(10)
    elsif params[:rate] == "4"
      @reviews = Review.where(item_id: @item.id, rate: 4)
      @reviews = Kaminari.paginate_array(@reviews).page(params[:page]).per(10)
    elsif params[:rate] == "5"
      @reviews = Review.where(item_id: @item.id, rate: 5)
      @reviews = Kaminari.paginate_array(@reviews).page(params[:page]).per(10)
    else
      @reviews = Kaminari.paginate_array(@reviews).page(params[:page]).per(10)
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to request.referer
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to items_path
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

end
