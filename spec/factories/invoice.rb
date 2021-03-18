FactoryBot.define do
  factory :invoice do
    customer_id { Customer.order('RANDOM()').first.id }
    merchant_id { Merchant.order('RANDOM()').first.id }
    status      { rand(0...3) }
  end
end