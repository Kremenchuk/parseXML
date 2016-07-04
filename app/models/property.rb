class Property < ApplicationRecord
  has_many :handbooks
  belongs_to :classifier

end
