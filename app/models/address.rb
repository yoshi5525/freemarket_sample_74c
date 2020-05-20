class Address < ApplicationRecord
  validates :family_name, :first_name,              format: {with: /\A[ぁ-んァ-ン一-龥]+\z/}, allow_blank: true
  validates :family_name, :first_name,              presence: true
  validates :first_name_kana, :family_name_kana,    format: {with: /\A[ァ-ヶー－]+\z/}, allow_blank: true
  validates :first_name_kana, :family_name_kana,    presence: true
  validates :tel_number,                            numericality: {only_integer: true}, length: {in: 10..11}, uniqueness: true,  allow_blank: true
  validates :post_code,                             format: {with: /\A\d{3}[-]\d{4}\z/}, allow_blank: true
  validates :post_code,                             presence: true
  validates :prefecture,                            numericality: { only_integer: true, message: "を選択してください"}
  validates :city, :address, presence: true

  belongs_to :user, optional: true
end