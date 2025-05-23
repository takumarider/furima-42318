class User < ApplicationRecord
devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :birth_date
    validates :last_name, :first_name, format: { with: /\A[ぁ-んァ-ン一-龥々ーヶ]+\z/ }
    validates :last_name_kana, :first_name_kana, format: { with: /\A[ァ-ヶー]+\z/ }
  end

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX }
end
