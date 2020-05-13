class Image < ApplicationRecord
  belongs_to :item

  validates :image, presence: true

  mount_uploader :image, ImageUploader
end