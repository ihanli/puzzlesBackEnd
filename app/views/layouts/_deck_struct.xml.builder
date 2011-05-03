xml.Deck(:name => deck.name){
  render 'card_struct', { :cards => @deck.cards }
}