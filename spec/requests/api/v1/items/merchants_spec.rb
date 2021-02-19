require 'rails_helper'

RSpec.describe "Merchants", type: :request do
  describe "GET an Item's Merchant" do
    describe "(happy path)" do
      it "fetches a Merchant by id" do
        merchant = create(:merchant)
        item = create(:item)

        get api_v1_item_merchant_index_path(item)
        expect(response.status).to eq(200)

        json = JSON.parse(response.body)
        expect(json["data"]["id"].to_i).to eq(merchant.id)
      end
    end

    describe "(sad path)" do
      it "returns 404 error given incorrect item id" do
        get api_v1_item_merchant_index_path(0)
        expect(response.status).to eq(404)

        get api_v1_item_merchant_index_path(1000)
        expect(response.status).to eq(404)
      end
      it "returns 404 error when item id is string" do
        merchant = create(:merchant)
        item = create(:item)

        get api_v1_item_merchant_index_path("cat")
        expect(response.status).to eq(404)
      end
    end
  end
end