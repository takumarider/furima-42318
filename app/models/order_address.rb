class OrderAddress
  include ActiveModel::Model
  attr_accessor :token, :postal_code, :prefecture_id, :city, :house_number, :building_name,
                :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :house_number
    validates :phone_number
    validates :token
  end
  validates :user_id, presence: { message: 'を入力してください' }
  validates :item_id, presence: { message: 'を入力してください' }

  # 郵便番号の形式（例: 123-4567）
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'はハイフンを含めてください' }

  # 都道府県の選択（--- などが選ばれていないか）
  validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }

  # 電話番号の形式（半角数字10〜11桁）
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は10桁または11桁の数字で入力してください' }
  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      house_number: house_number,
      building_name: building_name,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end
