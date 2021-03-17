
class Api::V1::Merchants::MerchantsController < ApplicationController
  def index
    merchants = MerchantsFacade.get_merchants(params[:page], params[:per_page])
    render json: MerchantSerializer.new(merchants)
  end

  def show 
    begin
      merchant = Merchant.find(params[:id])
      render json: MerchantSerializer.new(merchant)
    rescue
      render json: {"error" => {}}, status:404
    end
  end

  def most_items
    begin
      require 'pry'; binding.pry
      merchants = Merchant.merchant_sold_most_items(params[:quantity])
      render json: MerchantListSerializer.new(merchants)
    rescue

    end
  end
end
