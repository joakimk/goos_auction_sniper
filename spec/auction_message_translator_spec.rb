require 'spec_helper'
require 'auction_message_translator'
require 'chat'

describe AuctionMessageTranslator do
  UNUSED_USER = nil
  UNUSED_CHAT = nil

  let(:listener) { mock(AuctionEventListener) }
  let(:translator) { AuctionMessageTranslator.new(listener) }

  it "notifies that the auction is closed when a close message is received" do
    listener.should_receive(:auction_closed).once

    message = Chat::Message.new(UNUSED_USER, "SOLVersion: 1.1; Event: CLOSE;")
    translator.process_message(UNUSED_CHAT, message)
  end
end
