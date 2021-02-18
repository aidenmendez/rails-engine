FactoryBot.define do
  factory :item do
    name        { Faker::Hipster.words(3).join(" ") }
    description { Faker::Lorem.sentence(word_count: 8) }
    unit_price  { rand(1.01...99999.99).round(2) }
    merchant_id { Merchant.order('RANDOM()').first }
  end
end