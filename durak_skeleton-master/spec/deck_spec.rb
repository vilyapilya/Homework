require 'card'
require 'deck'

describe Deck do
  describe "::all_cards" do
    subject(:all_cards) { Deck.all_cards }
    it "returns an array of length 36" do
      expect(all_cards).to be_instance_of(Array)
      expect(all_cards.count).to eq(36)
    end

    it "returns all cards without duplicates" do
      deduped_cards = all_cards
        .map { |card| [card.suit, card.value] }
        .uniq
        .count
      expect(deduped_cards).to eq(36)
    end
  end

  let(:cards) do
    cards = [
      Card.new(:hearts, :queen),
      Card.new(:hearts, :king),
      Card.new(:hearts, :ten),
      Card.new(:clubs, :six),
      Card.new(:clubs, :seven),
      Card.new(:clubs, :nine)
    ]
  end

  describe "#initialize" do
    it "by default fills itself with 36 cards" do
      deck = Deck.new
      expect(deck.count).to eq(36)
    end

    it "can be initialized with an array of cards" do
      deck = Deck.new(cards)
      expect(deck.count).to eq(6)
    end
  end

  let(:deck) do
    Deck.new(cards.dup)
  end

  it "does not expose its cards directly" do
    expect(deck).to_not respond_to(:cards)
  end

  describe "#take_one" do
    it "removes one card from the deck" do
      deck.take_one
      expect(deck.count).to eq(5)
    end

    it "doesn't allow you to take more cards than are in the deck" do
      expect { deck.take_one }.to_not raise_error
      5.times { deck.take_one }
      expect { deck.take_one }.to raise_error("not enough cards")
    end
  end
end
