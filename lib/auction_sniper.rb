class AuctionSniper
  def initialize(listener)
    @listener = listener
  end

  def auction_closed
    @listener.sniper_lost
  end
end

