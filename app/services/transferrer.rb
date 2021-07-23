# frozen_string_literal: true

class Transferrer
  def self.call(request)
    new(request).call
  end

  def initialize(request)
    @request = request
  end

  def call
    return ActionResult.failure(message: @request.errors.full_messages.to_sentence) unless @request.valid?

    sender = UserFetcher.call(email: @request.from)
    receiver = UserFetcher.call(email: @request.to)

    BalanceUpdater.call({ sender => - @request.amount, receiver => @request.amount })
  end
end
