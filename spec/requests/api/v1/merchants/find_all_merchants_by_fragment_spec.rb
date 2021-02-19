require 'rails_helper'

RSpec.describe "Merchant Search", type: :request do
  describe "Fetch all Merchants by Name Fragment" do
    describe "(happy path)" do
      it "returns all partial name matches" do
        merchant1 = create(:merchant, name: "The Tool Shed")
        merchant2 = create(:merchant, name: "Cool Cats Hats")
        merchant3 = create(:merchant, name: "Socks Incorporated")
        merchant4 = create(:merchant, name: "Pool Party")

        get "/api/v1/merchants/find_all?name=ool"

        expect(response.status).to eq(200)
        json = JSON.parse(response.body)

        expect(json["data"].count).to eq(3)
        expect(json["data"]).to include(MerchantSerializer.new(merchant1))

        get "/api/v1/merchants/find_all?name=ool"

        expect(response.status).to eq(200)
        json = JSON.parse(response.body)

        expect(json.count).to eq(3)



      end
    end
  end
end