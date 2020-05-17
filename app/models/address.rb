class Address < ApplicationRecord
  validates :first_name, :family_name, :first_name_kana, :family_name_kana, :post_code, :prefecture, :city, :address, presence: true
  validates :first_name, :family_name,           format: {with: /\A[ぁ-んァ-ン一-龥]/}
  validates :first_name_kana, :family_name_kana, format: {with: /\A[ァ-ヶー－]+\z/}
  validates :tel_number, uniqueness: true,       format: {with: /\A\d{10,11}\z/, allow_blank: true}
  validates :post_code,                          format: {with: /\A\d{3}[-]\d{4}\z/}

  belongs_to :user, optional: true
end