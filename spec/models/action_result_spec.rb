# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ActionResult do
  shared_examples_for 'instance of container with result' do |status|
    it do
      expect(subject).to be_instance_of(described_class::Container)
      expect(subject[:success]).to eq(status)
    end
  end

  describe '.success' do
    subject { described_class.success }

    it_behaves_like 'instance of container with result', true

    it 'contains empty message' do
      expect(subject[:message]).to eq('')
    end
  end

  describe '.failure' do
    subject { described_class.failure(message: message) }

    let(:message) { SecureRandom.hex }

    it_behaves_like 'instance of container with result', false

    it 'contains error message' do
      expect(subject[:message]).to eq(message)
    end
  end
end
