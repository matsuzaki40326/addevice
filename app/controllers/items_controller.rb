class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    item = Item.new(item_params)
    item.save
    redirect_to request.referer
  end

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @review = Review.new
    @reviews = Review.where(item_id: @item.id)
    @average = @reviews.average(:rate)
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
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :image)
  end

end
