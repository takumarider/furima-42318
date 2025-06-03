class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:destroy, :edit, :update]

  def index
    @items = Item.includes(:user).order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def show
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to root_path, notice: '商品を出品しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item), notice: '商品情報を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path, notice: '商品を削除しました'
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    return unless current_user != @item.user || @item.order.present?

    redirect_to root_path, alert: '権限がありません'
  end

  def item_params
    params.require(:item).permit(
      :image, :name, :description,
      :category_id, :status_id,
      :shipping_fee_id, :prefecture_id,
      :shipping_day_id, :price
    )
  end
end
