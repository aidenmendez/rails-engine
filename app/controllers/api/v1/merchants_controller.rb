
class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = MerchantsFacade.get_merchants(params[:page], params[:per_page])
    render json: MerchantSerializer.new(merchants)
  end

  def show 
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.new(merchant)
  end
end
