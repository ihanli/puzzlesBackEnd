xml.Deck(:name => deck.name){
  xml << render(:partial => 'layouts/card_struct', :locals => { :cards => deck.cards } )
}