require 'rails_helper'

RSpec.describe 'Merchants', type: :request do
  describe "fetch all merchants" do
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
  end
end
