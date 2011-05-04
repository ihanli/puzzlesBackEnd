xml.instruct!
xml.DeckCollection do
  @decks.each do |deck|
    xml << render(:partial => 'layouts/deck_struct', :locals => { :deck => deck, :cards => deck.cards })
  end
end