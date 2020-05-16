class Address < ApplicationRecord
  validates :post_code, :prefecture, :city, :address, :apartment, presence: true
  belongs_to :user, optional: true
end