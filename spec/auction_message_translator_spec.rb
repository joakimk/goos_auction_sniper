require 'spec_helper'
require 'auction_message_translator'
require 'chat'

describe AuctionMessageTranslator do
  UNUSED_USER = nil
  UNUSED_CHAT = nil
  SNIPER_ID = "sniper"

  let(:listener) { mock }
  let(:translator) { AuctionMessageTranslator.new(SNIPER_ID, listener) }

  it "notifies that the auction is closed when a close message is received" do
    listener.should_receive(:auction_closed).once

    message = Chat::Message.new(UNUSED_USER, "SOLVersion: 1.1; Event: CLOSE;")
    translator.process_message(UNUSED_CHAT, message)
  end

  it "notifies about bid details when the current price message is received from other bidder" do
    listener.should_receive(:current_price).with(192, 7, PriceSource::OTHER).once

    message = Chat::Message.new(UNUSED_USER, "SOLVersion: 1.1; Event: PRICE; CurrentPrice: 192; Increment: 7; Bidder: Someone else;")
    translator.process_message(UNUSED_CHAT, message)
  end

  it "notifies about bid details when the current price message is received from the sniper" do
    listener.should_receive(:current_price).with(234, 5, PriceSource::SNIPER).once

    message = Chat::Message.new(UNUSED_USER, "SOLVersion: 1.1; Event: PRICE; CurrentPrice: 234; Increment: 5; Bidder: #{SNIPER_ID};")
    translator.process_message(UNUSED_CHAT, message)
  end
end
