require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
  end

  describe '購入情報の保存' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_address).to be_valid
        expect { @order_address.save }.to change(Order, :count).by(1).and change(Address, :count).by(1)
      end

      it 'building_nameが空でも保存できる' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end

    context '必須項目のバリデーション' do
      it 'tokenが空では保存できない' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'postal_codeが空では保存できない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'prefecture_idが空では保存できない' do
        @order_address.prefecture_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空では保存できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end

      it 'house_numberが空では保存できない' do
        @order_address.house_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("House number can't be blank")
      end

      it 'phone_numberが空では保存できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'user_idが空では保存できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('User を入力してください')
      end

      it 'item_idが空では保存できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Item を入力してください')
      end
    end

    context 'フォーマットのバリデーション' do
      it 'postal_codeにハイフンがないと保存できない' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code はハイフンを含めてください')
      end

      it 'phone_numberが9桁以下では保存できない' do
        @order_address.phone_number = '090123456'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number は10桁または11桁の数字で入力してください')
      end

      it 'phone_numberが12桁以上では保存できない' do
        @order_address.phone_number = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number は10桁または11桁の数字で入力してください')
      end

      it 'phone_numberにハイフンが含まれていると保存できない' do
        @order_address.phone_number = '090-1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number は10桁または11桁の数字で入力してください')
      end

      it 'postal_codeが正しいフォーマットなら保存できる' do
        @order_address.postal_code = '123-4567'
        expect(@order_address).to be_valid
      end
    end

    context 'prefecture_idの値の範囲チェック' do
      it 'prefecture_idが1では保存できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Prefecture を選択してください')
      end

      it 'prefecture_idが2以上なら保存できる' do
        @order_address.prefecture_id = 2
        expect(@order_address).to be_valid
      end
    end

    context 'phone_numberの追加パターンチェック' do
      it '全角数字が入っていると保存できない' do
        @order_address.phone_number = '０９０１２３４５６７８' # 全角
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number は10桁または11桁の数字で入力してください')
      end
    end
  end
end
