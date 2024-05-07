class OrdersController < ApplicationController
  def index
    #(学習コメント)ルーティングでネストしているので親モデル_idを取得している
    @item = Item.find(params[:item_id])
    @order = PayForm.new
  end
end
