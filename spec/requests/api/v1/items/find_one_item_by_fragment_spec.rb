require 'rails_helper'

RSpec.describe 'Item Search', type: :request do
  describe "Fetch One Item" do
    describe "(happy path)" do
      it "returns a single item and a status of 200" do
        merchant = create(:merchant)
        item = create(:item, name: "Bananagrams")

        # get "/api/v1/items/find_one?name=banana"
        get api_v1_items_find_one_path(params: {"name" => "banana"})
        expect(response.status).to eq(200)

        json = JSON.parse(response.body)

        expect(json["data"]["item"]["name"]).to eq("Bananagram")
      end

      it "returns only the first matching item when there are multiple results (case-sensative alphabetical order)" do

      end
    end
  end
end