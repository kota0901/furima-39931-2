class ItemsController < ApplicationController
  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      return redirect_to root_path
    end
    render 'new'
  end

  private

  def item_params
    params.require(:item).permit(
      :image,
      :item_name,
      :item_text,
      :category_id,
      :situation_id,
      :delivery_fee_payment_id,
      :region_id,
      :deadline_id,
      :price
    ).merge(user_id: current_user.id)
  end
end
