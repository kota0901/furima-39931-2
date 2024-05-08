require 'rails_helper'

RSpec.describe PayForm, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order = FactoryBot.build(:pay_form, user_id: user.id, item_id: item.id)
    sleep 0.1
  end

  describe '商品購入' do
    context '内容に問題ない場合' do
      it '全ての値が問題なく入っている場合、登録ができる' do
        expect(@order).to be_valid
      end
      it '建物名がなくても保存ができる' do
        @order.building = ''
        expect(@order).to be_valid
      end
    end
    context '内容に問題がある場合' do
      it 'postal_codeが空では登録できない' do
        @order.postal_code = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeにハイフンがないと登録できない' do
        @order.postal_code = '1234567'
        @order.valid?
        expect(@order.errors.full_messages).to include('Postal code is invalid')
      end
      it 'postal_codeに文字が含まれていると登録できない' do
        @order.postal_code = '123-abcd'
        @order.valid?
        expect(@order.errors.full_messages).to include('Postal code is invalid')
      end
      it 'regionが空では登録できない' do
        @order.region_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Region can't be blank")
      end
      it 'regionの値が0では登録できない' do
        @order.region_id = 0
        @order.valid?
        expect(@order.errors.full_messages).to include("Region must be other than 0")
      end
      it 'municipalitiesが空では登録できない' do
        @order.municipalities = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Municipalities can't be blank")
      end
      it 'banchiが空では登録できない' do
        @order.banchi = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Banchi can't be blank")
      end
      it 'numberが空では登録できない' do
        @order.number = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Number can't be blank")
      end
      it 'numberが長すぎたら登録できない' do
        @order.number = '012345678901'
        @order.valid?
        expect(@order.errors.full_messages).to include("Number is too long (maximum is 11 characters)")
      end
      it 'numberに文字が含まれていれば登録できない' do
        @order.number = '012345abcde'
        @order.valid?
        expect(@order.errors.full_messages).to include("Number is invalid")
      end
      it 'user_idが存在しなければ登録できない' do
        @order.user_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが存在しなければ登録できない' do
        @order.item_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空では登録できない' do
        @order.token = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end