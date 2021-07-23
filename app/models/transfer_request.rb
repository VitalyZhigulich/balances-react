# frozen_string_literal: true

class TransferRequest
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :from
  attribute :to
  attribute :amount, :decimal

  validates :from, :to, :amount, presence: true
  validates :amount, numericality: { other_than: 0 }

  validate :self_transfer_validation

  private

  def self_transfer_validation
    errors.add(:to, "'to' argument can't be equal with 'from'") if from == to
  end
end
