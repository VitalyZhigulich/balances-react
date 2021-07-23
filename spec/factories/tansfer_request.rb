# frozen_string_literal: true

FactoryBot.define do
  factory :transfer_request, class: 'TransferRequest' do
    from { SecureRandom.hex }
    to { SecureRandom.hex }

    amount { rand(1..100) }
  end
end
