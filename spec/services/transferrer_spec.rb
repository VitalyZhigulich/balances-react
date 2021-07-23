# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transferrer do
  describe '.call' do
    subject { described_class.call(request) }

    let(:request) { build(:transfer_request) }

    let(:user1) { build(:user) }
    let(:user2) { build(:user) }

    let(:deltas_by_user) { { user1 => - request.amount, user2 => request.amount } }
    let(:updater_result) { SecureRandom.hex }

    before do
      allow(UserFetcher).to receive(:call).with(email: request.from).and_return(user1)
      allow(UserFetcher).to receive(:call).with(email: request.to).and_return(user2)

      allow(BalanceUpdater).to receive(:call).with(deltas_by_user).and_return(updater_result)
    end

    it "calls BalanceUpdater and returrns it's result" do
      expect(subject).to eq(updater_result)
    end

    context 'with invalid request' do
      let(:request) { build(:transfer_request, amount: 0) }

      it 'returns failure action result with request error message' do
        expect(BalanceUpdater).not_to receive(:call)

        expect(subject.success).to eq(false)
        expect(subject.message).to eq(request.errors.full_messages.to_sentence)
      end
    end
  end
end
