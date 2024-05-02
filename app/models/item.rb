class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :situation
  belongs_to :delivery_fee_payment
  belongs_to :region
  belongs_to :deadline

  with_options presence: true do
    validates :image
    validates :item_name
    validates :item_text
    validates :price
  end

  with_options presence: true,numericality: { other_than: 0 } do
    validates :category_id
    validates :situation_id
    validates :delivery_fee_payment_id
    validates :region_id
    validates :deadline_id
  end

  validates :price, numericality: { only_integer: true,
    greater_than_or_equal_to: 300, 
    less_than_or_equal_to: 9_999_999 }
end
