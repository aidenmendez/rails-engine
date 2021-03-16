class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  validates_presence_of :name

  def self.find_by_name(search_term)
    where("name ILIKE ?", "%#{search_term}%")
  end

  def self.merchant_sold_most_items(merch_quantity = 5)
    Merchant.joins(invoices: :purchase)
    .joins("INNER JOIN invoice_items ON invoice_items.invoice_id = invoices.id")
    .where("invoices.status='shipped' AND purchases.result='success'")
    .group("merchants.id")
    .select("merchants.*, SUM(invoice_items.quantity) AS item_count")
    .order("item_count DESC")
    .limit(merch_quantity)
  end
end
