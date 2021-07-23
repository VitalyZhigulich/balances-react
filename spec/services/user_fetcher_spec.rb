# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserFetcher do
  describe '.call' do
    subject { described_class.call(email: email) }

    let(:email) { SecureRandom.hex }

    context 'when user exists' do
      let!(:user) { create(:user, email: email) }

      it 'returns found user' do
        expect(subject).to eq(user)
      end
    end

    context 'when user absent' do
      context 'when user created successfully' do
        let(:user_stub) { instance_double(User) }

        before do
          allow(User).to receive(:create!).with(email: email).and_return(user_stub)
        end

        it { is_expected.to eq(user_stub) }
      end

      context 'when user was created by someone else between find and create' do
        let(:user) { create(:user, email: email) }

        before do
          allow(User).to receive(:create!).with(email: email) do
            user

            raise ActiveRecord::RecordNotUnique
          end
        end

        it 'returns that created user' do
          expect(subject).to eq(user)
        end
      end
    end
  end
end
