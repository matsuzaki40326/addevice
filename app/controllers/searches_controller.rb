class SearchesController < ApplicationController

  def filter
    @categories = Category.all
    @makers = Maker.all
    @search_params = item_search_params
    search_items = Item.search(@search_params)
      if params[:sort] == "1"
        items = search_items.each do |item|
          item.average = item.review_rate_average
        end
        sort_items = items.sort_by { |item| item.average }.reverse
        @items = Kaminari.paginate_array(sort_items).page(params[:page]).per(12)
        search_items = sort_items
      elsif params[:sort] == "2"
        items = search_items.each do |item|
          item.amount = item.review_amount
        end
        sort_items = items.sort_by { |item| item.amount }.reverse
        @items = Kaminari.paginate_array(sort_items).page(params[:page]).per(12)
        search_items = sort_items
      else
        @items = Item.search(@search_params).page(params[:page]).per(12)
      end

    # Active record ではなく素のオブジェクトに戻す
    gon.items = search_items.to_a.map {|item| item.attributes.merge(avg: item.review_rate_average)}
  end


  private

  def item_search_params
    params.fetch(:search, {}).permit(:category_id, :maker_id, :sort, category_ids: [], maker_ids: [])
  end

end
