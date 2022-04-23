class SearchesController < ApplicationController

  def filter
    @categories = Category.all
    @makers = Maker.all
    @search_params = item_search_params
    items = Item.search(@search_params)
      if params[:sort] == "1"
        @items = items.each do |item|
          item.average = item.review_rate_average
        end
        @items = @items.sort_by { |item| item.average }.reverse
        @items = Kaminari.paginate_array(@items).page(params[:page]).per(12)
      elsif params[:sort] == "2"
        @items = items.each do |item|
          item.amount = item.review_amount
        end
        @items = @items.sort_by { |item| item.amount }.reverse
        @items = Kaminari.paginate_array(@items).page(params[:page]).per(12)
      else
        @items = Item.search(@search_params).page(params[:page]).per(12)
      end
  end


  private

  def item_search_params
    params.fetch(:search, {}).permit(:category_id, :maker_id, :sort, category_ids: [], maker_ids: [])
  end

end
