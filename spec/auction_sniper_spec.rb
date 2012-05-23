require 'spec_helper'
require 'auction_sniper'

describe AuctionSniper do
  let(:listener) { mock }
  let(:auction) { mock }
  let(:sniper) { AuctionSniper.new(auction, listener) }

  it "reports that it lost when the auction closes" do
    listener.should_receive(:sniper_lost).once
    sniper.auction_closed
  end

  it "bids higher and reports it is bidding when a new price arrives" do
    auction.should_receive(:bid).with(1026)
    listener.should_receive(:sniper_bidding).at_least(:once)
    sniper.current_price(1001, 25)
  end
end
