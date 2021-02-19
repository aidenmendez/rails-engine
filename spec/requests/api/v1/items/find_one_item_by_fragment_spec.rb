require 'rails_helper'

RSpec.describe 'Item Search', type: :request do
  describe "Fetch One Item" do
    describe "(happy path)" do
      it "with a name param it returns a single item and a status of 200" do
        merchant = create(:merchant)
        item = create(:item, name: "Bananagrams")

        get api_v1_items_find_path(params: {"name" => "banana"})
        expect(response.status).to eq(200)

        json = JSON.parse(response.body)
        expect(json["data"]["attributes"]["name"]).to eq("Bananagrams")
      end

      it "with a name param it returns only the first matching item when there are multiple results (case-sensative alphabetical order)" do
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
        expect(json["data"]["attributes"]["name"]).to be_nil
      end

      it "with a min_price param it returns one item with a price greater than or equal to the value" do
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

      it "with a max_price param it returns one item with a price less than or equal to the value" do
        merchant = create(:merchant)
        item = create(:item, name: "Oranges and Bananas", unit_price: 10)
        item = create(:item, name: "Bananagrams", unit_price: 35)
        item = create(:item, name: "Zebra Horse Man", unit_price: 100)


        get "/api/v1/items/find?max_price=15"

        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        
        expect(json["data"]["attributes"]["name"]).to eq("Oranges and Bananas")

        get "/api/v1/items/find?max_price=35"

        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        
        expect(json["data"]["attributes"]["name"]).to eq("Bananagrams")

        get "/api/v1/items/find?max_price=120"

        expect(response.status).to eq(200)
        json = JSON.parse(response.body)

        expect(json["data"]["attributes"]["name"]).to eq("Zebra Horse Man")
      end

      it "with a max and min price parameter returns an item in that range" do
        merchant = create(:merchant)
        item = create(:item, name: "Oranges and Bananas", unit_price: 10)
        item = create(:item, name: "Bananagrams", unit_price: 35)
        item = create(:item, name: "Zebra Horse Man", unit_price: 100)

        get "/api/v1/items/find?max_price=25&min_price=10"

        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        
        expect(json["data"]["attributes"]["name"]).to eq("Oranges and Bananas")
      end
    end

    describe "(sad path)" do
      it "doesn't accept a name param AND a min_price and/ or max_price param" do
        merchant = create(:merchant)
        item = create(:item, name: "Oranges and Bananas", unit_price: 10)
        item = create(:item, name: "Bananagrams", unit_price: 35)
        item = create(:item, name: "Zebra Horse Man", unit_price: 100)

        get "/api/v1/items/find?max_price=25&min_price=10&name=horse"
        expect(response.status).to eq(404)
      end
    end
  end
end