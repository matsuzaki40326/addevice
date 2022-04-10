class MakersController < ApplicationController
  def create
    maker = Maker.new(maker_params)
    maker.save
    flash[:notice] = "メーカーを追加しました。"
    redirect_to request.referer
  end


  private

  def maker_params
    params.require(:maker).permit(:name)
  end
end
