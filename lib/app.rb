require "chat"
require "auction_message_translator"
require "auction_sniper"

class App
  def initialize(ui, item_id)
    @ui = ui
    Chat.instance.listen("sniper", "auction-#{item_id}") do |message|
      translator = AuctionMessageTranslator.new(AuctionSniper.new(self))
      translator.process_message(Chat.instance, message)
    end
    Chat.instance.send_message("sniper", "auction-#{item_id}", "SOLVersion: 1.1; Command: JOIN;")
  end

  def sniper_lost
    @ui.status = "lost"
  end
end
