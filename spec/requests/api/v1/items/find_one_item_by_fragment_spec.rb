require 'rails_helper'

RSpec.describe 'Item Search', type: :request do
  describe "Fetch One Item" do
    describe "(happy path)" do
      it "name param returns a single item and a status of 200" do
        merchant = create(:merchant)
        item = create(:item, name: "Bananagrams")

        get api_v1_items_find_path(params: {"name" => "banana"})
        expect(response.status).to eq(200)

        json = JSON.parse(response.body)
        expect(json["data"]["attributes"]["name"]).to eq("Bananagrams")
      end

      it "name param returns only the first matching item when there are multiple results (case-sensative alphabetical order)" do
        merchant = create(:merchant)
        item = create(:item, name: "Oranges and Bananas")
        item = create(:item, name: "Bananagrams")
        item = create(:item, name: "Zebra Banana Man")


        get "/api/v1/items/find?name=banana"

        expect(response.status).to eq(200)

        json = JSON.parse(response.body)
        expect(json["data"]["attributes"]["name"]).to eq("Bananagrams")
      end

      it "returns an empty object if there is no match" do
        get "/api/v1/items/find?name=banana"
        
        expect(response.status).to eq(200)

        json = JSON.parse(response.body)
      end

      it "min_price param returns one item with a price greater than or equal to the value" do
        merchant = create(:merchant)
        item = create(:item, name: "Oranges and Bananas", unit_price: 10)
        item = create(:item, name: "Bananagrams", unit_price: 35)
        item = create(:item, name: "Zebra Banana Man", unit_price: 100)


        get "/api/v1/items/find?min_price=20"

        expect(response.status).to eq(200)
        json = JSON.parse(response.body)

        expect(json["data"]["attributes"]["name"]).to eq("Bananagrams")

        get "/api/v1/items/find?min_price=10"

        expect(response.status).to eq(200)
        json = JSON.parse(response.body)

        expect(json["data"]["attributes"]["name"]).to eq("Oranges and Bananas")

        get "/api/v1/items/find?min_price=90"

        expect(response.status).to eq(200)
        json = JSON.parse(response.body)

        expect(json["data"]["attributes"]["name"]).to eq("Zebra Banana Man")
      end

      it "max_price param returns one item with a price less than or equal to the value" do
        
      end
    end

    describe "(sad path)" do
      it "doesn't accept a name param AND a min_price and/ or max_price param" do

      end
    end
  end
end