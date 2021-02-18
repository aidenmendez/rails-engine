require 'rails_helper'

RSpec.describe 'Merchants', type: :request do
  describe "fetch all merchants" do
    describe "(happy path)" do
      it 'succeeds when there is something to fetch' do
        merchant1 = create(:merchant)
        merchant2 = create(:merchant)
        merchant3 = create(:merchant)
  
        get api_v1_merchants_path
        expect(response.status).to eq(200)
  
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:data].count).to eq(3)
  
        expect(json[:data][0][:attributes][:name]).to eq(merchant1.name)
        expect(json[:data][0][:id]).to eq(merchant1.id.to_s)
  
        expect(json[:data][1][:attributes][:name]).to eq(merchant2.name)
        expect(json[:data][1][:id]).to eq(merchant2.id.to_s)
        
        expect(json[:data][2][:attributes][:name]).to eq(merchant3.name)
        expect(json[:data][2][:id]).to eq(merchant3.id.to_s)
      end
      
      it 'limits the number of results to 20 by default' do
        100.times { create(:merchant) }
    
        get api_v1_merchants_path
        expect(response.status).to eq(200)
    
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:data].count).to eq(20)
      end

      it "can return a specific number of items per page" do
        125.times { create(:merchant) }
        amount = 50
        get api_v1_merchants_path(params: {per_page: amount})

        json = JSON.parse(response.body)

        expect(json["data"].count).to eq(amount)
      end

      it "can return a specific page (offset by increments of 20 by default)" do
        125.times { create(:merchant) }
  
        get api_v1_merchants_path(params: {page: 1})
        json = JSON.parse(response.body)
        first_pg_id = json["data"].first["id"].to_i

        get api_v1_merchants_path(params: {page: 2})
        json = JSON.parse(response.body)
        second_pg_id = json["data"].first["id"].to_i

        get api_v1_merchants_path(params: {page: 3})
        json = JSON.parse(response.body)
        third_pg_id = json["data"].first["id"].to_i

        expect(json["data"].count).to eq(20)
        expect(second_pg_id).to eq(first_pg_id + 20)
        expect(third_pg_id).to eq(second_pg_id + 20)
      end

      it "can return a specific page with a specific number of results" do
        Merchant.destroy_all
        125.times { create(:merchant) }
        base_id = Merchant.first.id
        amount = 15
        page_number = 4

        get api_v1_merchants_path(params: {page: page_number, per_page: amount})
        json = JSON.parse(response.body)
        first_result_id = json["data"].first["id"].to_i
        
        expect(first_result_id).to eq(base_id + (amount * (page_number - 1)))
      end
    end
    
    describe "(sad path)" do
      it "returns an empty array when there are no merchants to fetch" do
        get api_v1_merchants_path
        expect(response.status).to eq(200)
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:data]).to eq([])
      end
    end
  end

  describe "fetch a single merchant" do
    describe "(happy path)" do
      it "can return a single merchant" do
        merchant1 = create(:merchant)
    
        get api_v1_merchant_path(merchant1)
        expect(response.status).to eq(200)
    
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:data][:id]).to eq(merchant1.id.to_s)
        expect(json[:data][:type]).to eq("merchant")
        expect(json[:data][:attributes][:name]).to eq(merchant1.name)
      end
    end

    describe "(sad path)" do
      it "merchant path returns a 404 when given a nonexistent merchant id" do
        get api_v1_merchant_path(0)
        expect(response.status).to eq(404)
      end
    end
  end
end
