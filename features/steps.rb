$: << "lib"

require "app"
require "ui"
require "fake_auction_server"

Given /^an auction is selling an item$/ do
  @auction = FakeAuctionServer.new("item-54321")
  @auction.start_selling_item
end

Given /^an Auction Sniper has started to bid in that auction$/ do
  @ui = UI.new
  app = App.new(@ui)
  app.join_auction(@auction.item_id)
end

Then /^the auction will receive a join request from the Auction Sniper$/ do
  @auction.should have_received_join_request_from("sniper")
end

When /^an auction announces that it is closed$/ do
  @auction.announce_closed
end

Then /^the Auction Sniper will show that it has (.+?)$/ do |event|
  @ui.status.should == event
end

When /^the auction reports a price of "(.*?)" with an increment of "(.*?)" from "(.*?)"$/ do |price, increment, bidder|
  @auction.report_price(price.to_i, increment.to_i, bidder)
end

Then /^the Auction Sniper will show that it is (.+?)$/ do |status|
  @ui.status.should == status
end

Then /^the auction will have received a bid of "(.*?)" from the Auction Sniper$/ do |amount|
  @auction.should have_received_bid(amount.to_i, "sniper")
end
