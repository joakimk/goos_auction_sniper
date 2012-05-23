require 'singleton'

class Chat
  class Connection
    def initialize(user, channel, &block)
      @user = user
      @channel = channel
      @chat = Chat.instance
    end

    def listen
      @chat.listen(@user, @channel) do |message|
        yield message
      end
    end

    def send_message(message)
      @chat.send_message(@user, @channel, message)
    end
  end

  include Singleton

  class Message < Struct.new(:user, :body); end

  def initialize
    @messages = {}
  end

  def send_message(user, channel, message)
    @messages[channel] ||= []
    @messages[channel] << Message.new(user, message)

    # ensure messages have arrived
    sleep 0.25
  end

  def listen(user, channel)
    Thread.new do
      index = 0
      loop do
        if @messages[channel] && @messages[channel].size > index
          m = @messages[channel][index]
          if m.user != user
            yield m
          end
          index += 1
        end
        sleep 0.05
      end
    end
  end
end
