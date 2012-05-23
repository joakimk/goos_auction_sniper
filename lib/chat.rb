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
    @listeners = {}
  end

  def send_message(sender, channel, message)
    @listeners[channel].each do |receiver, block|
      if sender != receiver
        block.call(Message.new(sender, message))
      end
    end
  end

  def listen(user, channel, &block)
    @listeners[channel] ||= {}
    @listeners[channel][user] = block
  end
end
