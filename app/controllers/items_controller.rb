class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
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
    render :new, status: :unprocessable_entity
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)

    if @item.seve
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
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
