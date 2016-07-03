class PaymentAccount < ApplicationRecord
  has_one :bank
  belongs_to :owner
end
