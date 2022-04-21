class MakersController < ApplicationController
  before_action :only_admin
  def create
    maker = Maker.new(maker_params)
    if maker.save
      redirect_to request.referer, notice: "メーカーを追加しました。"
    else
      redirect_to request.referer, alert: "追加できませんでした。"
    end
  end

  def destroy
    maker = Maker.find(params[:id])
    maker.destroy
    flash[:notice] = "メーカーを削除しました。"
    redirect_to request.referer
  end


  private

  def maker_params
    params.require(:maker).permit(:name)
  end

  def only_admin
    unless current_user.admin
      redirect_to user_path(current_user)
     end
  end
end
