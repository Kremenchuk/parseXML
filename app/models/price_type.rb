class PriceType < ApplicationRecord
  belongs_to :tax
  has_many :price
end
