class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
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
    @item = Item.find(params[:id])
    return if current_user == @item.user

    redirect_to root_path, alert: '他のユーザーの商品は編集できません'
  end

  def update
    @item = Item.find(params[:id])
    if @item.user != current_user
      redirect_to root_path, alert: '他のユーザーの商品は編集できません'
    elsif @item.update(item_params)
      redirect_to item_path(@item), notice: '商品情報を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :image, :name, :description,
      :category_id, :status_id,
      :shipping_fee_id, :prefecture_id,
      :shipping_day_id, :price
    )
  end
end
