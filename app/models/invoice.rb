class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: [ :pending, :packaged, :shipped, :returned ]
end
