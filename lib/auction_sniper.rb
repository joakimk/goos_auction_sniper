require "chat"
require "ui"

class AuctionSniper
  def initialize(ui, item_id)
    Chat.instance.listen("sniper", "auction-#{item_id}") do |user, message|
      ui.status = "lost"
    end
    Chat.instance.send_message("sniper", "auction-#{item_id}", "SOLVersion: 1.1; Command: JOIN;")
  end
end
