# frozen_string_literal: true

class User < ApplicationRecord
  validates :balance, numericality: { greater_than: 0 }

  after_commit :publish_updates

  private

  def publish_updates
    UsersChannel.publish(self)
  end
end
