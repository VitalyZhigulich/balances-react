# frozen_string_literal: true

class BalanceUpdater
  def self.call(deltas_by_user)
    new(deltas_by_user).call
  end

  def initialize(deltas_by_user)
    @deltas_by_user = deltas_by_user
  end

  def call
    with_errors_handling do
      @deltas_by_user.sort.each do |user, delta|
        user.with_lock do
          user.balance += delta
          user.save!
        end
      end
    end
  end

  private

  def with_errors_handling(&block)
    ApplicationRecord.transaction(&block)

    ActionResult.success
  rescue ActiveRecord::RecordInvalid => e
    ActionResult.failure(message: e.message)
  end
end
