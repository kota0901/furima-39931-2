class OrdersController < ApplicationController
  def index
    //ルーティングでネストしているので親モデル_idを取得している
    @item = Item.find(params[:item_id])
    @order = PayForm.new
  end
end
