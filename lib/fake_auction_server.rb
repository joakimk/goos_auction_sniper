class FakeAuctionServer
  attr_reader :item_id

  def initialize(item_id)
    @item_id = item_id
    @chat = Chat::Connection.new("auction", "auction-#{item_id}")
  end

  def has_received_join_request_from?(user)
    @last_message.user == user && @last_message.body == "SOLVersion: 1.1; Command: JOIN;"
  end

  def announce_closed
    @chat.send_message("SOLVersion: 1.1; Event: CLOSE;")
  end

  def report_price(price, increment, bidder)
    message = "SOLVersion: 1.1; Event: PRICE; " +
      "CurrentPrice: #{price}; Increment: #{increment}; Bidder: #{bidder};"
    @chat.send_message(message)
  end

  def has_received_bid?(amount, user)
    @last_message.user == user && @last_message.body == "SOLVersion: 1.1; Command: BID; Price: #{amount};"
  end

  def start_selling_item
    @chat.listen do |message|
      @last_message = message
    end
  end
end

