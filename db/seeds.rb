# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $(whoami) -d rails-engine_development db/data/rails-engine-development.pgdump"
# puts "Loading PostgreSQL Data dump into local database with command:"
# puts cmd
# system(cmd)

50.times do
  Merchant.create!(name: Faker::Company.name)
end

100.times do
  Customer.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end

500.times do
  Item.create!(
    name: Faker::Hipster.words(3).join(" "),
    description: Faker::Lorem.sentence(word_count: 8),
    unit_price: rand(1.01...99999.99).round(2),
    merchant_id: Merchant.order('RANDOM()').first.id
  )
end

2000.times do
  merchant = Merchant.order('RANDOM()').first

  inv = Invoice.create!(
    customer_id: Customer.order('RANDOM()').first.id,
    merchant_id: merchant.id,
    status: ['pending', 'packaged', 'shipped', 'returned'].sample
  )

  InvoiceItem.create!(
    invoice_id: inv.id,
    item_id: merchant.items.order('RANDOM()').first.id,
    quantity: rand(1...1000),
    unit_price: rand(1.01...99999.99).round(2)
  )

  Purchase.create!(
    invoice_id: inv.id,
    credit_card_number: Faker::Business.credit_card_number,
    credit_card_expiration_date: Faker::Business.credit_card_expiry_date,
    result: ['success', 'failed', 'refunded'].sample
  )
end

