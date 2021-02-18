class ItemsFacade
  def self.get_items(page, per_page)
    page      ||= 1
    per_page  ||= 20

    Item.all.limit(per_page).offset(per_page.to_i * (page.to_i - 1))
  end
end