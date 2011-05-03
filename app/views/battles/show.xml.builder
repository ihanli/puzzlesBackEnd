xml.instruct!
xml.Battle(:id => @battle.id){
  @battle.fighters.each do |fighter|
    xml.Fighter(:status => fighter.state, :mana => fighter.mana, :health => fighter.health){
      xml.fb_id(fighter.user.fb_id)

	  render 'deck_struct', { :deck => fighter.deck, :cards => fighter.deck.cards.ready_to_play }
      
      xml.Hand{
        render 'card_struct', { :cards => fighter.deck.cards.drawn }
      }
      
      xml.SummonedUnits{
        render 'card_struct', { :cards => fighter.deck.cards.summoned }
      }
      
      xml.InactiveUnits{
        render 'card_struct', { :cards => fighter.deck.cards.inactive }
      }
      
      xml.AttackingUnits{
        render 'card_struct', { :cards => fighter.deck.cards.attacking }
      }
      
      xml.Spells{
        render 'card_struct', { :cards => fighter.deck.cards.casted }
      }
      
      xml.Cemetery{
        render 'card_struct', { :cards => fighter.deck.cards.destroyed }
      }
    }
  end
}