class PhysicalPersone < ApplicationRecord
  has_many :contractors, as: :personable, dependent: :destroy
  belongs_to :identity_card
end
