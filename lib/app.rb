require "chat"
require "auction_message_translator"
require "auction_sniper"

class App
  class Auction
    def initialize(chat, item_id)
      @chat = chat
      @item_id = item_id
    end

    def bid(amount)
      @chat.send_message("sniper", "auction-#{@item_id}", "SOLVersion: 1.1; Command: BID; Price: #{amount};")
    end

    def join
      @chat.send_message("sniper", "auction-#{@item_id}", "SOLVersion: 1.1; Command: JOIN;")
    end
  end

  def initialize(ui, item_id)
    @ui = ui

    chat = Chat.instance 
    auction = Auction.new(chat, item_id)

    chat.listen("sniper", "auction-#{item_id}") do |message|
      translator = AuctionMessageTranslator.new(AuctionSniper.new(auction, self))
      translator.process_message(chat, message)
    end

    auction.join
  end

  def sniper_lost
    @ui.status = "lost"
  end

  def sniper_bidding
    @ui.status = "bidding"
  end
end
