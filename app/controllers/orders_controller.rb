class OrdersController < ApplicationController
  def index
    #(学習コメント)ルーティングでネストしているので親モデル_idを取得している
    @item = Item.find(params[:item_id])
    @order = PayForm.new
  end

  def create
    binding.pry
    @item = Item.find(params[:item_id])
    @order = PayForm.new(order_params)
  
    if @order.valid? #バリデーションチェック
      @order.save #trueなら、フォームオブジェクトのsaveメソッドの呼び出し
      redirect_to root_path #処理後はリダイレクト
    else
      @item = Item.find(params[:item_id]) # indexで必要な@itemを再定義
      render 'index' # indexの再描写
    end
  
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
