class Api::V1::Items::SearchController < ApplicationController
  def find
    begin
      if params[:name] && (params[:min_price] || params[:max_price])
        raise "error", status: 404
      elsif params[:name]
        result = ItemSearchFacade.get_item_by_name(params[:name])
        render json: ItemSerializer.new(result), status: 200
      elsif params[:max_price] && params[:max_price]
        result = ItemSearchFacade.get_item_by_range(params[:min_price], params[:max_price])
        render json: ItemSerializer.new(result), status: 200
      elsif params[:min_price] && !params[:max_price]
        result = ItemSearchFacade.get_item_by_min_price(params[:min_price])
        render json: ItemSerializer.new(result), status: 200
      elsif params[:max_price] && !params[:min_price]
        result = ItemSearchFacade.get_item_by_max_price(params[:max_price])
        render json: ItemSerializer.new(result), status: 200
      else
        raise "error", status: 404
      end
    rescue
      render json: {"error" => {}}, status:404
    end
  end
end