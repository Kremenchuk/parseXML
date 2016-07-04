class Classifier < ApplicationRecord
  belongs_to :owner
  has_many :groups, as: :groupable, dependent: :destroy
  has_many :properties
  has_many :catalogs
end
