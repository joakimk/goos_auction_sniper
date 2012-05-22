require "chat"
require "ui"
require "auction_message_translator"

class AuctionSniper
  def initialize(ui, item_id)
    @ui = ui
    translator = AuctionMessageTranslator.new(self)
    Chat.instance.listen("sniper", "auction-#{item_id}") do |message|
      translator.process_message(Chat.instance, message)
    end
    Chat.instance.send_message("sniper", "auction-#{item_id}", "SOLVersion: 1.1; Command: JOIN;")
  end

  def auction_closed
    @ui.status = "lost"
  end
end

