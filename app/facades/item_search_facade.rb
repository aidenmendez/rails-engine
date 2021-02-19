class ItemSearchFacade
  def self.get_item_by_name(search_term)
    result = Item.single_search(search_term).first
    if result
      return result
    else
      return Item.new
    end
  end

  def self.get_item_by_min_price(price)
    result = Item.min_price_search(price).first
  end
end