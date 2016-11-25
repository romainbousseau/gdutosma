class Review < ApplicationRecord
  belongs_to :product
  validates :content, length: { minimum: 20 }
end
