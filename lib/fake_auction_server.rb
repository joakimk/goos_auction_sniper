class FakeAuctionServer
  attr_reader :item_id

  def initialize(item_id)
    @item_id = item_id
  end

  def has_received_join_request_from?(user)
    @last_message.user == user && @last_message.body == "SOLVersion: 1.1; Command: JOIN;"
  end

  def announce_closed
    chat = Chat.instance
    chat.send_message("auction", "auction-#{@item_id}", "CLOSED")
  end

  def report_price(price, increment, bidder)
    message = "SOLVersion: 1.1; Event: PRICE; " +
      "CurrentPrice: #{price}; Increment: #{increment}; Bidder: #{bidder};"
    chat = Chat.instance
    chat.send_message("auction", "auction-#{@item_id}", message)
  end

  def has_received_bid?(amount, user)
    @last_message.user == user && @last_message.body == "SOLVersion: 1.1; Command: BID; Price: #{amount};"
  end

  def start_selling_item
    chat = Chat.instance
    chat.listen("auction", "auction-#{@item_id}") do |message|
      @last_message = message
    end
  end
end

