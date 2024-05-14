class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :move_to_index

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    #(学習コメント)ルーティングでネストしているので親モデル_idを取得している
    @order = PayForm.new
  end

  def create
    @order = PayForm.new(order_params)
    if @order.valid? #バリデーションチェック
      @order.save #trueなら、フォームオブジェクトのsaveメソッドの呼び出し
      redirect_to root_path #処理後はリダイレクト
    else
      render :index, status: :unprocessable_entity
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
    ).merge(user_id: current_user.id,item_id: params[:item_id], token: params[:token])
end
def pay_item 
  Payjp.api_key = ENV['PAYJP_SECRET_KEY'] 
  Payjp::Charge.create(
    amount: @item.price, # 決済額
    card: order_params[:token], # カード情報
    currency: 'jpy' # 通貨単位
  )
end

def set_item
  @item = Item.find(params[:item_id])
end

def move_to_index
  # (学習用コメント) 出品したユーザー＆購入されていた場合トップページにリダイレクトする
  return redirect_to root_path if current_user.id == @item.user.id || @item.order.present?
end
end