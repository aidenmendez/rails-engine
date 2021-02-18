require 'rails_helper'

RSpec.describe "Items", type: :request do
  describe "GET All Items" do
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
        get api_v1_items_path
        expect(response.status).to eq(200)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data]).to eq([])
      end
    end
    
  end

  describe "GET One Item" do
    describe "(happy path)" do
      it "returns a single item when given an existing item id" do
        create(:merchant)
        item1 = create(:item)

        get api_v1_item_path(item1)
        expect(response.status).to eq(200)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data][:type]).to eq("item")
        expect(json[:data][:attributes][:name]).to eq(item1.name)
        expect(json[:data][:attributes][:description]).to eq(item1.description)
        expect(json[:data][:attributes][:unit_price]).to eq(item1.unit_price)
        expect(json[:data][:attributes][:merchant_id]).to eq(item1.merchant_id)
      end
    end

    describe "(sad path)" do
      it "returns a 404 error when given a nonexistent item id" do
        get api_v1_item_path(0)
        expect(response.status).to eq(404)
      end
    end
  end

  describe "POST an Item" do
    describe "(happy path)" do
      it "creates one new item" do
        merchant1 = create(:merchant)

        post api_v1_items_path(params: {:item => {name: "Beep name", merchant_id: merchant1.id, unit_price: 10.01, description: "More ipsum lorem"}})
        expect(response.status).to eq(201)
      end
    end

    describe "(sad path)" do
      it "returns an error if not all required parameters are present" do
        merchant1 = create(:merchant)
        post api_v1_items_path(params: {:item => {name: "Beep name", merchant_id: merchant1.id, description: "More ipsum lorem"}})
        expect(response.status).to eq(404)
      end
    end
  end

  describe "DELETE an Item" do
    describe "(happy path)" do
      it "deleting an item returns a 200 response" do
        create(:merchant)
        item = create(:item)

        delete api_v1_item_path(item)
        expect(response.status).to eq(201)
      end
    end

    describe "(sad path)" do
      it "trying to delete an item that doesn't exist returns a 404 response" do
        delete api_v1_item_path(0)
        expect(response.status).to eq(404)

        delete api_v1_item_path(1000000)
        expect(response.status).to eq(404)
      end
    end
  end

  describe "UPDATE an Item" do
    describe "(happy path)" do
      it "updates an existing item's data" do
        merchant = create(:merchant)
        item = create(:item)

        patch api_v1_item_path(item.id), params: {item: {name: "Beep name", unit_price: 100.50, merchant_id: merchant.id, description: "More ipsum lorem"}}
        expect(response.status).to eq(200)
        
        item.reload

        expect(item.name).to eq("Beep name")
        expect(item.unit_price).to eq(100.50)
      end
      it "updates an existing item's data even if given partial data" do
        merchant = create(:merchant)
        item = create(:item)

        patch api_v1_item_path(item.id), params: {item: {name: "Beep name"}}
        expect(response.status).to eq(200)

        item.reload

        expect(item.name).to eq("Beep name")
      end
    end
    describe "(sad path)" do
      it "returns 404 for nonexistent item id" do
        patch api_v1_item_path(0), params: {item: {name: "Beep name"}}
        expect(response.status).to eq(404)

        patch api_v1_item_path(1000000), params: {item: {name: "Beep name"}}
        expect(response.status).to eq(404)
      end

      it "returns 404 for merchant id not associated with the item" do
        merchant1 = create(:merchant)
        merchant2 = create(:merchant)
        item = create(:item, merchant_id: merchant1.id)

        patch api_v1_item_path(item.id), params: {item: {name: "Beep name", unit_price: 100.50, merchant_id: merchant2.id, description: "More ipsum lorem"}}
        expect(response.status).to eq(404)
      end

      it "returns 404 for a nonexistent merchant id" do
        merchant = create(:merchant)
        item = create(:item)

        patch api_v1_item_path(item.id), params: {item: {name: "Beep name", unit_price: 100.50, merchant_id:0, description: "More ipsum lorem"}}
        
      end
    end
  end
end