class Product < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :price, presence: true
  belongs_to :user
  has_many :rents
  CATEGORY = ["Video/Photo", "Sound", "Lights", "Accesories"]
end
