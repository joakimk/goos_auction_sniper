require 'spec_helper'
require 'auction_sniper'

describe AuctionSniper do
  let(:listener) { mock }
  let(:sniper) { AuctionSniper.new(listener) }

  it "reports that it lost when the auction closes" do
    listener.should_receive(:sniper_lost).once
    sniper.auction_closed
  end
end
