class PayForm
  include ActiveModel::Model
  attr_accessor :postal_code, :region_id, :municipalities, :banchi, :building_name, :number, :price, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/}
    validates :region_id, numericality: { other_than: 0 }
    validates :municipalities
    validates :banchi
    validates :number, length: { maximum: 11 }
    validates :user_id
    validates :item_id 
  end

  def save
    order = Order.create(
      item_id: item_id,
      user_id: user_id
    )
  
    Address.create(
      order_id: order.id,
      postal_code: postal_code,
      region_id: region_id,
      municipalities: municipalities,
      banchi: banchi,
      building_name: building_name,
      number: number
    )
  end
end