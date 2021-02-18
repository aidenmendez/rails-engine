require 'rails_helper'

RSpec.describe "Items", type: :request do
  describe "get All Items" do
    describe "(happy path)" do
      it "returns all existing items" do
        create(:merchant)
        item1 = create(:item)
        item2 = create(:item)
        item3 = create(:item)

        get api_v1_items_path
        expect(response.status).to eq(200)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data].count).to eq(3)
        expect(json[:data].first[:type]).to eq("item")
        expect(json[:data].first[:attributes][:name]).to be_a(String)
        expect(json[:data].first[:attributes][:description]).to be_a(String)
        expect(json[:data].first[:attributes][:unit_price]).to be_a(Numeric)
        expect(json[:data].first[:attributes][:merchant_id]).to be_an(Integer)
      end
    end

    describe "(sad path)" do
      it "returns empty array if there are no items" do

      end
    end
    
  end

  describe "get one item" do
    describe "(happy path)" do
      it "returns a single item when given an existing item id" do

      end
    end

    describe "(sad path)" do
      it "returns a 404 error when given a bad item id" do

      end
    end
  end

  describe "Get One Item" do

  end
end