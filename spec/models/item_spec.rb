require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品作成' do
    context '正常に保存ができる場合' do
      it '全ての情報が正しく入っていれば、保存ができる' do
        expect(@item).to be_valid
      end
    end

    context '正常に保存ができない場合' do
      it 'imageがないと保存ができない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'item_nameがないと保存ができない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end

      it 'item_textがないと保存ができない' do
        @item.item_text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item text can't be blank")
      end

      it 'priceがないと保存ができない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが300未満だと保存ができない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end

      it 'priceが10,000,000以上だと保存ができない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end

      it 'priceが文字列だと保存ができない' do
        @item.price = 'abc'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it 'category_idが0を選ばれていると保存ができない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 0")
      end

      it 'situation_idが0を選ばれていると保存ができない' do
        @item.situation_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Situation must be other than 0")
      end

      it 'delivery_fee_payment_idが0を選ばれていると保存ができない' do
        @item.delivery_fee_payment_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery fee payment must be other than 0")
      end

      it 'region_idが0を選ばれていると保存ができない' do
        @item.region_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Region must be other than 0")
      end

      it 'deadline_idが0を選ばれていると保存ができない' do
        @item.deadline_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Deadline must be other than 0")
      end
    end
  end
end
