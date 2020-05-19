class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :family_name, :first_name,              format: {with: /\A[ぁ-んァ-ン一-龥]+\z/}, allow_blank: true
  validates :family_name, :first_name, presence: true
  validates :first_name_kana, :family_name_kana,   format: {with: /\A[ァ-ヶー－]+\z/}, allow_blank: true
  validates :first_name_kana, :family_name_kana, presence: true
  validates :birth_year, :birth_month, :birth_day, numericality: { only_integer: true, message: "を選択してください"}
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: "は英字と数字を最低1つ入力してください"}, allow_blank: true
  validates :password, presence: true

  has_many :addresses, dependent: :destroy
  has_many :items,     dependent: :destroy

end
