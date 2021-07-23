# frozen_string_literal: true

class ActionResult
  Container = Struct.new(:success, :message)

  class << self
    def success
      Container.new(true, '')
    end

    def failure(message: '')
      Container.new(false, message)
    end
  end
end
