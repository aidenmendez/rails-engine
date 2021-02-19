class MerchantSearchFacade
  def self.find_by_name(search_term)
    if search_term == ""
      result = []
    else
      result = Merchant.find_by_name(search_term)
    end
  end
end