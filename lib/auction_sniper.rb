class AuctionSniper
  def initialize(auction, listener)
    @auction = auction
    @listener = listener
  end

  def auction_closed
    @listener.sniper_lost
  end

  def current_price(price, increment)
    @listener.sniper_bidding
    @auction.bid(price + increment)
  end
end

