class Bank < ApplicationRecord
  belongs_to :payment_account
  has_one :correspondent_bank, class_name: "Bank",
                              foreign_key: "correspondent_id"

  belongs_to :bank_master, class_name: "Bank"
end
