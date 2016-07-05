class ProductAttribute < ApplicationRecord
  has_and_belongs_to_many :products
  has_many :product_attribute_values
end
