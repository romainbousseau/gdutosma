class Product < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :price, presence: true
end
