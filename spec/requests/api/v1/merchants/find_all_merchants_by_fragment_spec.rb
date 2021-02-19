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

       
        expect(json["data"]).to be_an(Array)
        expect(json["data"].count).to eq(3)

        get "/api/v1/merchants/find_all?name=incor"

        expect(response.status).to eq(200)
        json = JSON.parse(response.body)

        expect(json["data"]).to be_an(Array)
        expect(json["data"].count).to eq(1)
      end

      it "returns an empty array when there are no matches" do
        merchant1 = create(:merchant, name: "The Tool Shed")
        merchant2 = create(:merchant, name: "Cool Cats Hats")

        get "/api/v1/merchants/find_all?name=ocks"

        expect(response.status).to eq(200)
        json = JSON.parse(response.body)

       
        expect(json["data"]).to be_an(Array)
        expect(json["data"].count).to eq(0)
      end
    end

    describe "(sad path)" do
      it "returns an empty array when no fragment is given" do
        merchant1 = create(:merchant, name: "The Tool Shed")
        merchant2 = create(:merchant, name: "Cool Cats Hats")

        get "/api/v1/merchants/find_all?name="

        expect(response.status).to eq(200)
        json = JSON.parse(response.body)

       
        expect(json["data"]).to be_an(Array)
        expect(json["data"].count).to eq(0)
      end
    end
  end
end