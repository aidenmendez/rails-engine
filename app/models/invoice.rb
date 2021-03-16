class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_one    :purchase, dependent: :destroy

  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items, dependent: :destroy

  enum status: [ :pending, :packaged, :shipped, :returned ]
end
