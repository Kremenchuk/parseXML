class Tax < ApplicationRecord
  #products
  has_many :product_tax_values
  has_many :products, through: :product_tax_values

  #price_types
  has_many :price_type_tax_values
  has_many :price_types, through: :price_type_tax_values


end
