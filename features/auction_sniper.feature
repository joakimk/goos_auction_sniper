Feature: Auction sniper

  Scenario: With a single item, join and loose without bidding
    Given an auction is selling an item
    And an Auction Sniper has started to bid in that auction
    Then the auction will receive a join request from the Auction Sniper
    When an auction announces that it is closed
    Then the Auction Sniper will show that it lost the auction
