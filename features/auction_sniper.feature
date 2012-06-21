Feature: Auction sniper

  Scenario: With a single item, join and loose without bidding
    Given an auction is selling an item
    And an Auction Sniper has started to bid in that auction
    Then the auction will receive a join request from the Auction Sniper
    When an auction announces that it is closed
    Then the Auction Sniper will show that it has lost

  Scenario: Sniper makes a higher bid but looses
    Given an auction is selling an item
    And an Auction Sniper has started to bid in that auction
    Then the auction will receive a join request from the Auction Sniper
    When the auction reports a price of "1000" with an increment of "98" from "other bidder"
    Then the Auction Sniper will show that it is bidding
    And the auction will have received a bid of "1098" from the Auction Sniper
    When an auction announces that it is closed
    Then the Auction Sniper will show that it has lost

  Scenario: Sniper wins and auction by bidding higher
    Given an auction is selling an item
    And an Auction Sniper has started to bid in that auction
    Then the auction will receive a join request from the Auction Sniper
    When the auction reports a price of "1000" with an increment of "98" from "sniper"
    Then the Auction Sniper will show that it is winning
    When an auction announces that it is closed
    Then the Auction Sniper will show that it has won
