class Api::V1::Items::ItemsController < ApplicationController
  def index
    items = ItemsFacade.get_items(params[:page], params[:per_page])
    render json: ItemSerializer.new(items)
  end

  def show
    binding.pry
  end
end