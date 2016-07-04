class MlCatalog < ApplicationRecord
  #has_many :products
  belongs_to :owner
  belongs_to :classifier

end
