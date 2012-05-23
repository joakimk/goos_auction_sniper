require "chat"
require "auction_message_translator"
require "auction_sniper"

class App
  class Auction
    def initialize(item_id)
      @item_id = item_id
    end

    def bid(amount)
      Chat.instance.send_message("sniper", "auction-#{@item_id}", "SOLVersion: 1.1; Command: BID; Price: #{amount};")
    end
  end

  def initialize(ui, item_id)
    @ui = ui

    chat = Chat.instance 
    chat.listen("sniper", "auction-#{item_id}") do |message|
      translator = AuctionMessageTranslator.new(AuctionSniper.new(Auction.new(item_id), self))
      translator.process_message(chat, message)
    end
    chat.send_message("sniper", "auction-#{item_id}", "SOLVersion: 1.1; Command: JOIN;")
  end

  def sniper_lost
    @ui.status = "lost"
  end

  def sniper_bidding
    @ui.status = "bidding"
  end
end
