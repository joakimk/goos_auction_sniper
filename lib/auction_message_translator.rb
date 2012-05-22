class AuctionMessageTranslator
  def initialize(listener)
    @listener = listener
  end

  def process_message(chat, message)
    event = unpack_event_from(message)
    case event["Event"]
    when "CLOSE"
      @listener.auction_closed
    when "PRICE"
      @listener.current_price(event["CurrentPrice"].to_i, event["Increment"].to_i)
    else
      raise
    end
  end

  private

  def unpack_event_from(message)
    message.body.split(";").inject({}) do |hash, element|
      k, v = element.split(':').map(&:strip)
      hash[k] = v
      hash
    end
  end
end
