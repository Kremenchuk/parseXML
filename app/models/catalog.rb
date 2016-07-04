class Catalog < ApplicationRecord
  belongs_to :owner
  belongs_to :classifier
end
