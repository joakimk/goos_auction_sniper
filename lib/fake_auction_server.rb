class FakeAuctionServer
  attr_reader :item_id

  def initialize(item_id)
    @item_id = item_id
  end

  def has_received_join_request_from_sniper?
    @join_request
  end

  def announce_closed
    chat = Chat.instance
    chat.send_message("auction", "auction-#{@item_id}", "CLOSED")
  end

  def start_selling_item
    chat = Chat.instance
    chat.listen("auction", "auction-#{@item_id}") do |message|
      @join_request = true
    end
  end
end

