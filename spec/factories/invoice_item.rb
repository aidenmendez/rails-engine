FactoryBot.define do
  factory :invoice_item do
    invoice_id  { Invoice.order('RANDOM()').first.id }
    item_id     { Item.order('RANDOM()').first.id }
    quantity    { rand(0...1000) }
    unit_price  { rand(1.01...99999.99).round(2) }
  end
end