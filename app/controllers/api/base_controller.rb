# frozen_string_literal: true

class Api::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token

  private

  def respond_with_action_result(result)
    if result.success
      head :ok
    else
      render json: { error: result.message }, status: :unprocessable_entity
    end
  end
end
