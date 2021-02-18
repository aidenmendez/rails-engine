class Api::V1::Items::MerchantController < ApplicationController
  def index
    begin
      item = Item.find(params[:item_id])
      render json: MerchantSerializer.new(item.merchant), status:200
    rescue
      render json: {"error" => {}}, status:404
    end
  end
end