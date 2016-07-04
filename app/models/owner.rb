class Owner < ApplicationRecord

  has_many :ml_catalogs
  has_many :classifiers
  has_many :payment_account

end
