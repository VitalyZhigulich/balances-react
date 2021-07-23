# frozen_string_literal: true

class UsersChannel < ApplicationCable::Channel
  class << self
    def publish(users, raise_errors: false)
      users = Array.wrap(users)

      ActionCable.server.broadcast(channel_name, { users: users.index_by(&:id) })
    rescue StandardError => e
      raise(e) if raise_errors
    end

    def channel_name
      name.underscore
    end
  end

  delegate :publish, :channel_name, to: :class

  def subscribed
    stream_from(channel_name)

    publish(User.all, raise_errors: true)
  end
end
