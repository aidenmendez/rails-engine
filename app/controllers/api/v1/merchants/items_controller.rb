class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    begin
      items = Merchant.find(params[:merchant_id]).items
      render json: ItemSerializer.new(items)
    rescue
      render json: { "error" => {}}, status:404
    end
  end
end