# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: 'User' do
    email { SecureRandom.hex }
  end
end
