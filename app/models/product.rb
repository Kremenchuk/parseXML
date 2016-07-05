class Product < ApplicationRecord
  belongs_to :unit
  belongs_to :catalog
  has_and_belongs_to_many :groups

  has_many :product_properties
  has_many :properties, through: :product_properties

  has_many :product_tax_values
  has_many :taxes, through: :product_tax_values

  has_many :requisites

  #has_and_belongs_to_many :product_attributes

  has_many :proposals
  has_many :product_images
  has_and_belongs_to_many :handbooks
end
