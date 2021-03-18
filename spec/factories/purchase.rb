FactoryBot.define do
  factory :purchase do
    invoice_id                  { Invoice.order('RANDOM()').first.id }
    credit_card_number          { Faker::Business.credit_card_number }
    credit_card_expiration_date { Faker::Business.credit_card_expiry_date }
    result                      { rand(0...2) }
  end
end