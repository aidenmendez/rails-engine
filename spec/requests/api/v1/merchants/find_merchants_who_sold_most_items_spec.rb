require 'rails_helper'

RSpec.describe "Merchants Most Items Request", type: :request do
  before(:each) do
    10.times do
      create(:customer)
    end

    merchant1 = create(:merchant, name: "The Tool Shed")
    merchant2 = create(:merchant, name: "Cool Cats Hats")
    merchant3 = create(:merchant, name: "Socks Incorporated")
    merchant4 = create(:merchant, name: "Pool Party")
    merchant5 = create(:merchant, name: "Water Bottle Co")
    merchant6 = create(:merchant, name: "Pictures, Framed")
    merchant7 = create(:merchant, name: "Sweater Weather")

    item1 = create(:item, :merchant_id => merchant1.id)
    item2 = create(:item, :merchant_id => merchant1.id)
    item3 = create(:item, :merchant_id => merchant2.id)
    item4 = create(:item, :merchant_id => merchant3.id)
    item5 = create(:item, :merchant_id => merchant3.id)
    item6 = create(:item, :merchant_id => merchant4.id)
    item7 = create(:item, :merchant_id => merchant5.id)
    item8 = create(:item, :merchant_id => merchant6.id)
    item9 = create(:item, :merchant_id => merchant7.id)

    invoice1 = create(:invoice, :merchant_id => merchant1.id, :status => 2)
    invoice2 = create(:invoice, :merchant_id => merchant2.id, :status => 2)
    invoice3 = create(:invoice, :merchant_id => merchant2.id, :status => 2)
    invoice4 = create(:invoice, :merchant_id => merchant3.id, :status => 2)
    invoice5 = create(:invoice, :merchant_id => merchant4.id, :status => 2)
    invoice6 = create(:invoice, :merchant_id => merchant4.id, :status => 2)
    invoice7 = create(:invoice, :merchant_id => merchant5.id, :status => 2)
    invoice8 = create(:invoice, :merchant_id => merchant6.id, :status => 2)
    invoice9 = create(:invoice, :merchant_id => merchant6.id, :status => 2)
    invoice10 = create(:invoice, :merchant_id => merchant6.id, :status => 2)
    invoice11 = create(:invoice, :merchant_id => merchant7.id, :status => 2)
    invoice12 = create(:invoice, :merchant_id => merchant7.id, :status => 2)

    invoice_item1 = create(:invoice_item, :invoice_id => invoice8.id, :item_id => item8.id, :quantity => 5000)
    invoice_item2 = create(:invoice_item, :invoice_id => invoice9.id, :item_id => item8.id, :quantity => 300)
    invoice_item3 = create(:invoice_item, :invoice_id => invoice11.id, :item_id => item9.id, :quantity => 2500)
    invoice_item4 = create(:invoice_item, :invoice_id => invoice2.id, :item_id => item3.id, :quantity => 5000)
    invoice_item5 = create(:invoice_item, :invoice_id => invoice1.id, :item_id => item1.id, :quantity => 150)
    invoice_item6 = create(:invoice_item, :invoice_id => invoice5.id, :item_id => item6.id, :quantity => 700)
    invoice_item7 = create(:invoice_item, :invoice_id => invoice4.id, :item_id => item5.id, :quantity => 10)

    purchase1 = create(:purchase, :invoice_id => invoice8.id, :result => 2)
    purchase2 = create(:purchase, :invoice_id => invoice9.id, :result => 2)
    purchase3 = create(:purchase, :invoice_id => invoice11.id, :result => 2)
    purchase4 = create(:purchase, :invoice_id => invoice2.id, :result => 2)
    purchase5 = create(:purchase, :invoice_id => invoice1.id, :result => 2)
    purchase6 = create(:purchase, :invoice_id => invoice5.id, :result => 2)
    purchase7 = create(:purchase, :invoice_id => invoice4.id, :result => 2)
  end

  it "fetches merchants who sold most items (no quantity provided)" do
    get '/api/v1/merchants/most_items'
    require 'pry'; binding.pry
  end

  it "fetches merchants who sold most items (quantity provided)" do
    get '/api/v1/merchants/most_items?quantity=10'
  end
end