# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TransferController do
  describe 'POST :create' do
    subject { post :create, params: request_params, as: :json }

    let(:request_params) { { from: from, to: to, amount: amount, foo: :bar } }
    let(:permitted_params) { ActionController::Parameters.new(request_params.slice(:from, :to, :amount)).permit! }
    let(:from) { SecureRandom.hex }
    let(:to) { SecureRandom.hex }
    let(:amount) { 25 }

    let(:transfer_request) { instance_double(TransferRequest) }

    before do
      allow(TransferRequest).to receive(:new).with(permitted_params).and_return(transfer_request)
      allow(Transferrer).to receive(:call).with(transfer_request).and_return(transfer_result)
    end

    context 'when transfer succeeds' do
      let(:transfer_result) { ActionResult.success }

      it 'returns 200 status' do
        subject

        expect(response.status).to eq(200)
      end
    end

    context 'when transfer fails' do
      let(:transfer_result) { ActionResult.failure(message: message) }
      let(:message) { SecureRandom.hex }

      it 'returns 422 status with message' do
        subject

        expect(response.status).to eq(422)
        expect(response.body).to eq({ error: message }.to_json)
      end
    end
  end
end
