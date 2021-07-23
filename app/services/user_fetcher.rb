# frozen_string_literal: true

class UserFetcher
  def self.call(email:)
    new(email).call
  end

  def initialize(email)
    @email = email
  end

  def call
    find_user || create_user
  end

  private

  def find_user
    User.find_by(email: @email)
  end

  def create_user
    User.create!(email: @email)
  rescue ActiveRecord::RecordNotUnique
    find_user
  end
end
