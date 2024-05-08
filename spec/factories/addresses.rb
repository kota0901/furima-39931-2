FactoryBot.define do
  factory :shipping_address do
    postal_code { 'MyString' }
    prefecture { 'MyString' }
    city { 'MyString' }
    house_number { 'MyString' }
    building_name { 'MyString' }
    phone_number { 'MyString' }
    purchase_history { nil }
  end
end