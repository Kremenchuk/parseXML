class Tax < ApplicationRecord
  has_many :product_tax_values
  has_many :products, through: :product_tax_values
  has_many :price_type
end
