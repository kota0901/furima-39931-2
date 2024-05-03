class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only:[:edit , :update, :destroy]

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
    
  end

  def edit
    
  end

  def update
    @item.update(item_params)
    if @item.seve
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy 
    redirect_to root_path
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

  def set_item
    @item = Item.find(params[:id]) 
  end

  def move_to_index
    return redirect_to root_path if current_user.id != @item.user.id
  end
end
