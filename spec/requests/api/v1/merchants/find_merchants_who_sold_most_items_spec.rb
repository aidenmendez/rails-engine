require 'rails_helper'

RSpec.describe "Merchants Most Items Request", type: :request do
  before(:each) do
    merchant1 = create(:merchant, name: "The Tool Shed")
    merchant2 = create(:merchant, name: "Cool Cats Hats")
    merchant3 = create(:merchant, name: "Socks Incorporated")
    merchant4 = create(:merchant, name: "Pool Party")
    merchant5 = create(:merchant, name: "Water Bottle Co")
    merchant6 = create(:merchant, name: "Pictures, Framed")
    merchant7 = create(:merchant, name: "Sweater Weather")
    item1 = create(:merchant => merchant1.id)
    item2 = create(:merchant => merchant1.id)
    item3 = create(:merchant => merchant2.id)
    item4 = create(:merchant => merchant3.id)
    item5 = create(:merchant => merchant3.id)
    item6 = create(:merchant => merchant4.id)
    item7 = create(:merchant => merchant5.id)
    item8 = create(:merchant => merchant6.id)
    item8 = create(:merchant => merchant7.id)
    
  end

  it "fetches merchants who sold most items (no quantity provided)" do
    get '/api/v1/merchants/most_items'
    require 'pry'; binding.pry
  end

  it "fetches merchants who sold most items (quantity provided)" do
    get '/api/v1/merchants/most_items?quantity=10'
  end
end