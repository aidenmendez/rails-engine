class Api::V1::Items::ItemsController < ApplicationController
  def index
    items = ItemsFacade.get_items(params[:page], params[:per_page])
    render json: ItemSerializer.new(items)
  end

  def show
    begin
      item = Item.find(params[:id])
      render json:ItemSerializer.new(item)
    rescue
      render json: {"error" => {}}, status:404
    end
  end
end