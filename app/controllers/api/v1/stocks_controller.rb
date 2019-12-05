# frozen_string_literal: true

class Api::V1::StocksController < ApplicationController
  # TODO: wrong place fot those constants. Move into a different location
  NOT_FOUND_HASH = { error: 'Not found' }.freeze
  UNABLE_TO_DELETE_HASH = { error: 'Unable to delete' }.freeze

  skip_before_action :verify_authenticity_token
  deserializable_resource :stock, only: %i[create update]

  def index
    render jsonapi: Stock.all,
           include: [:bearer],
           fields: { stocks: [:name], bearers: [:name] }
  end

  def create
    # TODO: Update this object initialization to using nested relations
    @stock = Bearer
            .find_or_initialize_by(name: stock_params[:bearer_id])
            .stocks.new(name: stock_params[:name])

    save_stock_and_respond
  end

  def update
    @stock = Stock.find_by(id: params[:id])

    # TODO: behaviour can be changed to catching NotFound error
    # Current implementation needs decomposition
    if @stock.present?
      # TODO: this code could get much easier if the correct relationship usage
      # is applied. Unfortunatelly, I haven't had enought time to explore
      # this library in details
      @stock.assign_attributes stock_params.permit(:name)
      if stock_params.key?(:bearer_id)
        @stock.bearer =
          Bearer.find_or_initialize_by(name: stock_params[:bearer_id])
      end

      save_stock_and_respond
    else
      # TODO: this responce should be refined
      render json: NOT_FOUND_HASH, status: :not_found
    end
  end

  def destroy
    # TODO: a lot of DRY
    stock = Stock.find_by(id: params[:id])

    if stock.present?
      stock.destroy!
      head :no_content
    else
      render json: NOT_FOUND_HASH, status: :not_found
    end
  rescue ActiveRecord::RecordNotDestroyed
    render json: UNABLE_TO_DELETE_HASH, status: :forbidden
  end

  def stock_params
    params.require(:stock)
  end

  def save_stock_and_respond
    # TODO: nested validation should be used here to combine errors
    if !@stock.bearer.valid?
      render jsonapi_errors: @stock.bearer.errors
    elsif @stock.valid?
      @stock.save
      render jsonapi: @stock
    else
      render jsonapi_errors: @stock.errors
    end
  end
end
