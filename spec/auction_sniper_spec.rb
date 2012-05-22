require 'spec_helper'
require 'auction_sniper'
require 'auction_sniper_listener'

describe AuctionSniper do
  let(:listener) { mock(AuctionSniperListener) }
  let(:sniper) { AuctionSniper.new(listener) }

  it "reports that it lost when the auction closes" do
    listener.should_receive(:sniper_lost).once
    sniper.auction_closed
  end
end
