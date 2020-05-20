class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :first_name, :family_name, :first_name_kana, :family_name_kana, :nickname, :birth_year, :birth_month, :birth_day, presence: true
  validates :first_name, :family_name,             format: {with: /\A[ぁ-んァ-ン一-龥]/}
  validates :first_name_kana, :family_name_kana,   format: {with: /\A[ァ-ヶー－]+\z/}
  validates :birth_year, :birth_month, :birth_day, format: {with: /\A[0-9]+\z/}, numericality: { only_integer: true , greater_than: 0}
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }

  has_many :addresses, dependent: :destroy
  has_many :items,     dependent: :destroy
  has_one :card

end
