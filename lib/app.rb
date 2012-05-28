require "chat"
require "auction_message_translator"
require "auction_sniper"

class App
  class Auction
    def initialize(chat)
      @chat = chat
    end

    def bid(amount)
      @chat.send_message("SOLVersion: 1.1; Command: BID; Price: #{amount};")
    end

    def join
      @chat.send_message("SOLVersion: 1.1; Command: JOIN;")
    end
  end

  class SniperStateDisplay
    def initialize(ui)
      @ui = ui
    end

    def sniper_lost
      @ui.status = "lost"
    end

    def sniper_bidding
      @ui.status = "bidding"
    end
  end

  def initialize(ui)
    @sniper_state_display = SniperStateDisplay.new(ui)
  end

  def join_auction(item_id)
    chat = Chat::Connection.new("sniper", "auction-#{item_id}")
    auction = Auction.new(chat)
    auction_sniper = AuctionSniper.new(auction, @sniper_state_display)

    chat.listen do |message|
      translator = AuctionMessageTranslator.new(auction_sniper)
      translator.process_message(chat, message)
    end

    auction.join
  end

end
