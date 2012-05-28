class AuctionMessageTranslator
  def initialize(listener)
    @listener = listener
  end

  def process_message(chat, message)
    event = AuctionEvent.new(message.body)
    case event.type
    when "CLOSE"
      @listener.auction_closed
    when "PRICE"
      @listener.current_price(event.current_price, event.increment.to_i)
    else
      raise
    end
  end

  private

  class AuctionEvent
    def initialize(message_body)
      @event = message_body.split(";").inject({}) do |hash, element|
        k, v = element.split(':').map(&:strip)
        hash[k] = v
        hash
      end
    end

    def current_price
      @event["CurrentPrice"].to_i
    end

    def increment
      @event["Increment"].to_i
    end

    def type
      @event["Event"]
    end
  end
end
