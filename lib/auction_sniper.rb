require 'price_source'

class AuctionSniper
  def initialize(auction, listener)
    @auction = auction
    @listener = listener
  end

  def auction_closed
    if @winning
      @listener.sniper_won
    else
      @listener.sniper_lost
    end
  end

  def current_price(price, increment, price_source)
    @winning = (price_source == PriceSource::SNIPER)
    if @winning
      @listener.sniper_winning
    else
      @listener.sniper_bidding
      @auction.bid(price + increment)
    end
  end
end

