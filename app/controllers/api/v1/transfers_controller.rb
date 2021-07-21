class Api::V1::TransfersController < Api::BaseController
  def create
    ActionCable.server.broadcast(UsersChannel.channel_name, { users: { 55 => { email: 'a', balance: 800 }, 1 => { email: 'b', balance: 1200 } } })

    render json: { success: true }
  end
end
