module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def self.channel_name
      self.name.underscore
    end

    delegate :channel_name, to: :class
  end
end
