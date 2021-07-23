# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransferRequest do
  subject { build(:transfer_request, params) }

  let(:params) { { amount: amount.to_s } }

  let(:amount) { 103.3 }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:from) }
  it { is_expected.to validate_presence_of(:to) }
  it { is_expected.to validate_presence_of(:amount) }

  it 'converts amount to decimal' do
    expect(subject.amount).to eq(amount)
  end

  context 'when amount is 0' do
    let(:amount) { 0 }

    it { is_expected.to be_invalid }
  end

  context 'when from is equal with to' do
    let(:params) { { from: email, to: email } }
    let(:email) { SecureRandom.hex }

    it { is_expected.to be_invalid }
  end
end
