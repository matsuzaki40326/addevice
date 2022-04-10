class CategoriesController < ApplicationController
  def create
    category = Category.new(category_params)
    category.save
    flash[:notice] = "カテゴリーを追加しました。"
    redirect_to request.referer
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
