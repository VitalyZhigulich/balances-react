# frozen_string_literal: true

class Api::V1::TransferController < Api::BaseController
  def create
    transfer_request = TransferRequest.new(params.permit(:from, :to, :amount))
    result = Transferrer.call(transfer_request)

    respond_with_action_result(result)
  end
end
