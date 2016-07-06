class Requisite < ApplicationRecord
  has_many :product_requisites
  has_many :products, through: :product_requisites
end
