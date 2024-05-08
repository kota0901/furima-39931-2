FactoryBot.define do
  factory :pay_form do
      token { 'sampletokensampletoken' }
      postal_code { '123-4567' }
      region_id { 1 }
      municipalities { '千代田区' }
      banchi { '丸の内3丁目3番１号' }
      building_name {'新東京ビル４F テックキャンプ 東京丸の内校'}
      number { '09012345678' }
  end
end
