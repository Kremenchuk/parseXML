class Catalog < ApplicationRecord
  belongs_to :owner
  belongs_to :classifier
  has_many :products
  has_many :offers
end
