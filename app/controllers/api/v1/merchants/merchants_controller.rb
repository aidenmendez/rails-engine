
class Api::V1::Merchants::MerchantsController < ApplicationController
  def index
    begin
      merchants = MerchantsFacade.get_merchants(params[:page], params[:per_page])
      render json: MerchantSerializer.new(merchants)
    rescue
      render json: {"error" => {}}, status:404
    end
  end

  def show 
    begin
      merchant = Merchant.find(params[:id])
      render json: MerchantSerializer.new(merchant)
    rescue
      render json: {"error" => {}}, status:404
    end
  end
end
