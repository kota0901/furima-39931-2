FactoryBot.define do
  factory :item do
    item_name { 'サンプル商品' }
    item_text { 'サンプル商品の説明' }
    price { 1000 }
    category_id { 1 }
    situation_id { 1 }
    delivery_fee_payment_id { 1 }
    region_id { 1 }
    deadline_id { 1 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
