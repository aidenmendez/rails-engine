class Api::V1::Items::SearchController < ApplicationController
  def find
    begin
      binding.pry
      result = Item.single_search(params[:name]).first
      render json: ItemSerializer.new(result), status: 200
    rescue
      render json: {"error" => {}}, status:404
    end
  end
end