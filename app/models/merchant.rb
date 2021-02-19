class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  validates_presence_of :name

  def self.find_by_name(search_term)
    where("name ILIKE ?", "%#{search_term}%")
  end
end
