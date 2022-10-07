# frozen_string_literal: true

class CheapestSailingsController < ApplicationController
  def index
    cheapest_options = Queries::Result.new(sailing_params[:origin_port], sailing_params[:destination_port], false).call
    render json: cheapest_options.to_json
  end

  private

  def sailing_params
    params.permit(:origin_port, :destination_port)
  end
end
