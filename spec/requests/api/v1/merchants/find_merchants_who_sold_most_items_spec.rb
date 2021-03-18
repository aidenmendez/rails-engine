require 'rails_helper'

RSpec.describe "Merchants Most Items Request", type: :request do
  before(:each) do
    10.times do
      create(:customer)
    end

    @merchant1 = create(:merchant, name: "The Tool Shed")
    @merchant2 = create(:merchant, name: "Cool Cats Hats")
    @merchant3 = create(:merchant, name: "Socks Incorporated")
    @merchant4 = create(:merchant, name: "Pool Party")
    @merchant5 = create(:merchant, name: "Water Bottle Co")
    @merchant6 = create(:merchant, name: "Pictures, Framed")
    @merchant7 = create(:merchant, name: "Sweater Weather")

    @item1 = create(:item, :merchant_id => @merchant1.id)
    @item2 = create(:item, :merchant_id => @merchant1.id)
    @item3 = create(:item, :merchant_id => @merchant2.id)
    @item4 = create(:item, :merchant_id => @merchant3.id)
    @item5 = create(:item, :merchant_id => @merchant3.id)
    @item6 = create(:item, :merchant_id => @merchant4.id)
    @item7 = create(:item, :merchant_id => @merchant5.id)
    @item8 = create(:item, :merchant_id => @merchant6.id)
    @item9 = create(:item, :merchant_id => @merchant7.id)

    @invoice1 = create(:invoice, :merchant_id => @merchant1.id, :status => "shipped")
    @invoice2 = create(:invoice, :merchant_id => @merchant2.id, :status => "shipped")
    @invoice3 = create(:invoice, :merchant_id => @merchant2.id, :status => "shipped")
    @invoice4 = create(:invoice, :merchant_id => @merchant3.id, :status => "shipped")
    @invoice5 = create(:invoice, :merchant_id => @merchant4.id, :status => "shipped")
    @invoice6 = create(:invoice, :merchant_id => @merchant4.id, :status => "shipped")
    @invoice7 = create(:invoice, :merchant_id => @merchant5.id, :status => "shipped")
    @invoice8 = create(:invoice, :merchant_id => @merchant6.id, :status => "shipped")
    @invoice9 = create(:invoice, :merchant_id => @merchant6.id, :status => "shipped")
    @invoice10 = create(:invoice, :merchant_id => @merchant6.id, :status => "shipped")
    @invoice11 = create(:invoice, :merchant_id => @merchant7.id, :status => "shipped")
    @invoice12 = create(:invoice, :merchant_id => @merchant7.id, :status => "shipped")

    @invoice_item1 = create(:invoice_item, :invoice_id => @invoice8.id, :item_id => @item8.id, :quantity => 5000)
    @invoice_item2 = create(:invoice_item, :invoice_id => @invoice9.id, :item_id => @item8.id, :quantity => 300)
    @invoice_item3 = create(:invoice_item, :invoice_id => @invoice11.id, :item_id => @item9.id, :quantity => 2500)
    @invoice_item4 = create(:invoice_item, :invoice_id => @invoice2.id, :item_id => @item3.id, :quantity => 5000)
    @invoice_item5 = create(:invoice_item, :invoice_id => @invoice1.id, :item_id => @item1.id, :quantity => 150)
    @invoice_item6 = create(:invoice_item, :invoice_id => @invoice5.id, :item_id => @item6.id, :quantity => 700)
    @invoice_item7 = create(:invoice_item, :invoice_id => @invoice4.id, :item_id => @item5.id, :quantity => 10)

    @purchase1 = create(:purchase, :invoice_id => @invoice8.id, :result => "success")
    @purchase2 = create(:purchase, :invoice_id => @invoice9.id, :result => "success")
    @purchase3 = create(:purchase, :invoice_id => @invoice11.id, :result => "success")
    @purchase4 = create(:purchase, :invoice_id => @invoice2.id, :result => "success")
    @purchase5 = create(:purchase, :invoice_id => @invoice1.id, :result => "success")
    @purchase6 = create(:purchase, :invoice_id => @invoice5.id, :result => "success")
    @purchase7 = create(:purchase, :invoice_id => @invoice4.id, :result => "success")
  end

  it "fetches merchants who sold most items (no quantity provided)" do
    get '/api/v1/merchants/most_items'
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)

    expect(json[:data]).to be_an(Array)
    expect(json[:data].count).to eq(5)
    expect(json[:data][0][:id]).to eq(@merchant6.id.to_s)
    expect(json[:data][0][:type]).to eq("items_sold")
    expect(json[:data][0][:attributes]).to be_a(Hash)
    expect(json[:data][0][:attributes][:name]).to eq(@merchant6.name)
    expect(json[:data][0][:attributes][:count]).to eq(5300)

    expect(json[:data][1][:id]).to eq(@merchant2.id.to_s)
    expect(json[:data][1][:type]).to eq("items_sold")
    expect(json[:data][1][:attributes]).to be_a(Hash)
    expect(json[:data][1][:attributes][:name]).to eq(@merchant2.name)
    expect(json[:data][1][:attributes][:count]).to eq(5000)

    expect(json[:data][2][:id]).to eq(@merchant7.id.to_s)
    expect(json[:data][2][:type]).to eq("items_sold")
    expect(json[:data][2][:attributes]).to be_a(Hash)
    expect(json[:data][2][:attributes][:name]).to eq(@merchant7.name)
    expect(json[:data][2][:attributes][:count]).to eq(2500)

    expect(json[:data][3][:id]).to eq(@merchant4.id.to_s)
    expect(json[:data][3][:type]).to eq("items_sold")
    expect(json[:data][3][:attributes]).to be_a(Hash)
    expect(json[:data][3][:attributes][:name]).to eq(@merchant4.name)
    expect(json[:data][3][:attributes][:count]).to eq(700)

    expect(json[:data][4][:id]).to eq(@merchant1.id.to_s)
    expect(json[:data][4][:type]).to eq("items_sold")
    expect(json[:data][4][:attributes]).to be_a(Hash)
    expect(json[:data][4][:attributes][:name]).to eq(@merchant1.name)
    expect(json[:data][4][:attributes][:count]).to eq(150)
  end

  it "fetches merchants who sold most items (quantity provided)" do
    get '/api/v1/merchants/most_items?quantity=10'
  end
end