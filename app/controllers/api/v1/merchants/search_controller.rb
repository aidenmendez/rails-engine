class Api::V1::Merchants::SearchController < ApplicationController
  def find_all
    begin
      if params[:name]
        result = MerchantSearchFacade.find_by_name(params[:name])
        render json: MerchantSerializer.new(result), status: 200
      end
    rescue
      render json: {"error" => {}}, status:404
    end
  end
end