xml.instruct!
xml.DeckCollection do
  @decks.each do |deck|
    render 'deck_struct', { :deck => deck, :cards => deck.cards }
  end
end