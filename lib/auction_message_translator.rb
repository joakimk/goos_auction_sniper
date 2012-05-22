require_relative 'auction_event_listener'

class AuctionMessageTranslator
  def initialize(listener)
    @listener = listener
  end

  def process_message(chat, message)
    @listener.auction_closed
  end
end
