class SearchesController < ApplicationController
  def search
    @items = Item.looks(params[:search], params[:word])
    @categories = Category.all
    @makers = Maker.all
  end

  def filter
    @categories = Category.all
    @makers = Maker.all
    @search_params = item_search_params
    @items = Item.search(@search_params)
  end


  private

  def item_search_params
    params.fetch(:search, {}).permit(:category_id, :maker_id, category_ids: [], maker_ids: [],)
  end

end
