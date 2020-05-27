class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :area
  belongs_to :seller, class_name: 'User', optional: true
  belongs_to :buyer, class_name: 'User', optional: true
  has_many :images, dependent: :destroy
  belongs_to :category
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name, length: { minimum: 1, maximum: 40 }, presence: true
  validates :introduction, length: { minimum: 1, maximum: 1000 }, presence: true
  validates :condition, presence: true
  validates :area, presence: true
  validates :price, numericality: { only_integer: true , greater_than: 299, less_than: 10000000 }, presence: true
  validates :preparation_day, presence: true
  validates :postage, presence: true
  validates :status, presence: true
  validates :seller_id, presence: true
  validates :images, presence: true

  enum preparation_day: [:short, :middle, :long]
  enum postage: [:including, :noincluding]
  enum brand: [:chanel, :nike, :LouisVuitton, :supreme, :adidas, :ex]
  enum condition: [:zero, :one, :two, :three, :four, :five]
  enum size: [:xs, :x, :m, :l, :ll, :lxl]
  enum status: [:saling_item, :sold_item]
end
