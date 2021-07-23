# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  subject { create(:user) }

  it { is_expected.to validate_numericality_of(:balance).is_greater_than(0) }

  describe 'after commit callback' do
    it 'publishes changes in to yhe channel' do
      expect(UsersChannel).to receive(:publish).with(subject)

      subject.run_callbacks(:commit)
    end
  end
end
