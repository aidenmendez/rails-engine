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

  def create
    begin
      item = Item.create!(item_params)
      render json: ItemSerializer.new(item), status:201
    rescue
      render json: {"error" => {}}, status:404
    end
  end

  def destroy
    begin
      Item.destroy(params[:id])
      render json: {"response" => {}}, status:201
    rescue
      render json: {"error" => {}}, status:404
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :merchant_id, :unit_price, :description)
  end
end