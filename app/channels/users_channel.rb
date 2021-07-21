class UsersChannel < ApplicationCable::Channel
  def subscribed
    stream_from(channel_name)

    ActionCable.server.broadcast(channel_name, { users: User.all.index_by(&:id) })
  end
end
