xml.instruct!
xml.Battle(:id => @battle.id){
  @battle.fighters.each do |fighter|
    xml.Fighter(:status => fighter.state, :mana => fighter.mana, :health => fighter.health){
      xml.fb_id(fighter.user.fb_id)

	  xml << render(:partial => 'layouts/deck_struct', :locals => { :deck => fighter.deck, :cards => fighter.deck.cards.ready_to_play })
      
      xml.Hand{
        xml << render(:partial => 'layouts/card_struct', :locals => { :cards => fighter.deck.cards.drawn })
      }
      
      xml.SummonedUnits{
        xml << render(:partial => 'layouts/card_struct', :locals => { :cards => fighter.deck.cards.summoned })
      }
      
      xml.InactiveUnits{
        xml << render(:partial => 'layouts/card_struct', :locals => { :cards => fighter.deck.cards.inactive })
      }
      
      xml.AttackingUnits{
		 xml << render(:partial => 'layouts/card_struct', :locals => { :cards => fighter.deck.cards.attacking })
      }
      
      xml.Spells{
       xml << render(:partial => 'layouts/card_struct', :locals => { :cards => fighter.deck.cards.casted })
      }
      
      xml.Cemetery{
        xml << render(:partial => 'layouts/card_struct', :locals => { :cards => fighter.deck.cards.destroyed })
      }
    }
  end
}