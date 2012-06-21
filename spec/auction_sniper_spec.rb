require 'spec_helper'
require 'auction_sniper'

describe AuctionSniper do
  let(:listener) { mock }
  let(:auction) { mock }
  let(:sniper) { AuctionSniper.new(auction, listener) }

  it "reports that it lost when the auction closes immediatley" do
    listener.should_receive(:sniper_lost).once
    sniper.auction_closed
  end

  it "bids higher and reports it is bidding when a new price arrives" do
    auction.should_receive(:bid).with(1026)
    listener.should_receive(:sniper_bidding).at_least(:once)
    sniper.current_price(1001, 25, PriceSource::OTHER)
  end

  it "reports that it is winning when the current price comes from the sniper" do
    listener.should_receive(:sniper_winning).at_least(:once)
    sniper.current_price(123, 45, PriceSource::SNIPER)
  end

  it "reports that it lost if the auction closes when it is bidding" do
    auction.as_null_object
    listener.stub(:sniper_bidding)
    listener.should_receive(:sniper_lost).at_least(:once)
    sniper.current_price(123, 45, PriceSource::OTHER)
    sniper.auction_closed
  end

  it "reports that it won if the auction closes when it is winning" do
    listener.stub(:sniper_winning)
    listener.should_receive(:sniper_won).at_least(:once)
    sniper.current_price(123, 45, PriceSource::SNIPER)
    sniper.auction_closed
  end
end
