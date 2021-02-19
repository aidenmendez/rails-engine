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
    if result
      return result
    else
      return Item.new
    end
  end

  def self.get_item_by_max_price(price)
    result = Item.max_price_search(price).first
    if result
      return result
    else
      return Item.new
    end
  end

  def self.get_item_by_range(min_price, max_price)
    result = Item.price_range_search(min_price, max_price).first
    if result
      return result
    else
      return Item.new
    end
  end

  private

  def self.check_result(result)
  end
end