# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BalanceUpdater do
  describe '.call' do
    subject { described_class.call(deltas_by_user) }

    let(:deltas_by_user) { { user1 => delta1, user2 => delta2 } }

    let(:user1) { create(:user) }
    let(:user2) { create(:user) }

    let(:delta1) { rand(1..5) }
    let(:delta2) { - rand(5..10) }

    it 'updates users balance' do
      expect { subject }
        .to change(user1.reload, :balance).to(user1.balance + delta1)
        .and change(user2.reload, :balance).to(user2.balance + delta2)
    end

    it 'returns successful action result' do
      expect(subject.success).to eq(true)
    end

    context 'when ActiveRecord::RecordInvalid raised' do
      before do
        allow(user2).to receive(:save!).and_raise(ActiveRecord::RecordInvalid)
      end

      it 'does not update users' do
        deltas_by_user.each_key do |user|
          expect { subject }.to_not change { user.reload.balance }
        end
      end

      it 'returns failure action result' do
        expect(subject.success).to eq(false)
      end
    end
  end
end
