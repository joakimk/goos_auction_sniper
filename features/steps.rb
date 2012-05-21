$: << "lib"

require "auction_sniper"
require "fake_auction_server"

Given /^an auction is selling an item$/ do
  @auction = FakeAuctionServer.new("item-54321")
  @auction.start_selling_item
end

Given /^an Auction Sniper has started to bid in that auction$/ do
  @ui = UI.new
  AuctionSniper.new(@ui, @auction.item_id)
  sleep 0.1
end

Then /^the auction will receive a join request from the Auction Sniper$/ do
  @auction.should have_received_join_request_from_sniper
end

When /^an auction announces that it is closed$/ do
  @auction.announce_closed
  sleep 0.1
end

Then /^the Auction Sniper will show that it lost the auction$/ do
  @ui.status.should == "lost"
end
