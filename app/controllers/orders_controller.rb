class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :prevent_seller_from_buying, only: [:index, :create]
  def index
    @order_address = OrderAddress.new
    gon.item_name = @item.name
    gon.item_price = @item.price
    gon.payjp_public_key = ENV.fetch('PAYJP_PUBLIC_KEY', nil)
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path, notice: '商品を購入しました！'
    else
      gon.public_key = ENV.fetch('PAYJP_PUBLIC_KEY', nil)
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: '商品が見つかりません'
    nil
  end

  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :prevent_seller_from_buying, only: [:index, :create]

  def order_address_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :token
    ).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def prevent_seller_from_buying
    if @item.user_id == current_user.id
      redirect_to root_path, alert: '自分の商品は購入できません'
      nil
    elsif @item.order.present?
      redirect_to root_path, alert: 'すでに購入済みの商品です'
      nil
    end
  end

  def pay_item
    Payjp.api_key = ENV.fetch('PAYJP_SECRET_KEY', nil) # ← 修正
    Payjp::Charge.create(
      amount: @item.price,
      card: order_address_params[:token],
      currency: 'jpy'
    )
  end
end
