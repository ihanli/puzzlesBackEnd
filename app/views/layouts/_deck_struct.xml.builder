xml.Deck(:name => deck.name){
  xml << render(:partial => 'card_struct', :locals => { :cards => deck.cards } )
}