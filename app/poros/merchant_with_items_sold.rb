class MerchantWithItemsSold
  attr_reader :id, :count, :name

  def initialize(merchant)
    @id = merchant.id
    @count = merchant.item_count
    @name = merchant.name
  end
end