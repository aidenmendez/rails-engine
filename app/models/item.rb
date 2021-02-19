class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items, dependent: :destroy

  validates_presence_of :name, :description, :unit_price, :merchant_id

  def self.single_search(search_term)
    where("name ILIKE ?", "%#{search_term}%")
    .order("name")
    .limit(1)
  end

  def self.min_price_search(price)
    where("unit_price >= ?", price.to_i)
    .limit(1)
  end
end
