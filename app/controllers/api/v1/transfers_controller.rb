class Api::V1::TransfersController < Api::BaseController
  def create
    ActionCable.server.broadcast(UsersBalanceChannel.channel_name, { users: [] })

    render json: { success: true }
  end
end
