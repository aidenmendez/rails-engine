
class Api::V1::MerchantsController < ApplicationController
  def index
    # if params[:page] && params[:count]
    # require 'pry'; binding.pry
      merchants = MerchantsFacade.get_merchants(params[:page], params[:per_page])
    # else
    #   merchants = MerchantsFacade.get_merchants
    # end

    render json: MerchantSerializer.new(merchants)
  end

  def show 
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end
end
