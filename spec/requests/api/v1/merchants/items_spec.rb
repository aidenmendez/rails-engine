require 'rails_helper'

RSpec.describe "Items", type: :request do
  describe "fetch all items for a merchant" do
    describe "(happy path)" do
      it 'can return items for a merchant' do
        merchant1 = create(:merchant)
        merchant2 = create(:merchant)
  
        5.times do 
         create(:item, merchant_id: merchant1.id)
        end
  
        2.times do 
          create(:item, merchant_id: merchant2.id)
        end
  
        get api_v1_merchant_items_path(merchant1)
  
        expect(response.status).to eq(200)
  
        json = JSON.parse(response.body, symbolize_names: true)
  
        expect(json[:data].count).to eq(5)
        expect(json[:data].first[:type]).to eq("item")
        expect(json[:data].first[:attributes][:name]).to be_a(String)
        expect(json[:data].first[:attributes][:description]).to be_a(String)
        expect(json[:data].first[:attributes][:unit_price]).to be_a(Numeric)
        expect(json[:data].first[:attributes][:merchant_id]).to be_an(Integer)
      end
    end

    describe "(sad path)" do
      it "returns a 404 error when given a nonexistent merchant id" do
        get api_v1_merchant_items_path(0)
        expect(response.status).to eq(404)
      end
    end
  end

end