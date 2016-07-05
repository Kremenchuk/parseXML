class Offer < ApplicationRecord
  belongs_to :classifier
  belongs_to :catalog
  belongs_to :owner
  has_many :price_type

end
