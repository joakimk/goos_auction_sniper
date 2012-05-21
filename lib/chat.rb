require 'singleton'

class Chat
  include Singleton

  def initialize
    @messages = {}
  end

  def send_message(user, channel, message)
    @messages[channel] ||= []
    @messages[channel] << { user: user, message: message }
  end

  def listen(user, channel)
    Thread.new do
      index = 0
      loop do
        if @messages[channel] && @messages[channel].size > index
          m = @messages[channel][index]
          if m[:user] != user
            yield m[:user], m[:message]
          end
          index += 1
        end
        sleep 0.05
      end
    end
  end
end
