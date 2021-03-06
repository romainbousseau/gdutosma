class Product < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :price, presence: true
  belongs_to :user
  has_many :rents
  has_attachments :photos, maximum: 3
  has_many :reviews, dependent: :nullify
  CATEGORY = ["Video/Photo", "Sound", "Lights", "Accessories"]
end
