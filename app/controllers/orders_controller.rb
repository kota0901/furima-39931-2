class OrdersController < ApplicationController
  def index
    #(学習コメント)ルーティングでネストしているので親モデル_idを取得している
    @item = Item.find(params[:item_id])
    @order = PayForm.new
  end

  private

def order_params
  params.require(:pay_form).permit(
    :postal_code,
    :region_id,
    :municipalities,
    :banchi,
    :building_name,
    :number
    ).merge(user_id: current_user.id,item_id: params[:item_id])
end
end
