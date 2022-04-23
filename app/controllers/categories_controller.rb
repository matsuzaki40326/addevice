class CategoriesController < ApplicationController
  before_action :only_admin
  def create
    category = Category.new(category_params)
     if category.save
       redirect_to request.referer, notice: "カテゴリーを追加しました。"
     else
       redirect_to request.referer, alert: "追加できませんでした。"
     end
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    redirect_to request.referer
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def only_admin
    unless current_user.admin
      redirect_to user_path(current_user)
     end
  end
end
