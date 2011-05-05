xml.instruct!
xml.Battle(:id => @battle.id){
  @battle.fighters.each do |fighter|
    xml.Fighter(:status => fighter.state, :mana => fighter.mana, :health => fighter.health){
      xml.fb_id(fighter.user.fb_id)

	  xml << render(:partial => 'layouts/deck_struct', :locals => { :deck => fighter.deck, :cards => fighter.deck.cards.select { |c| c.ready_to_play? } })
      
      xml.Hand{
        xml << render(:partial => 'layouts/card_struct', :locals => { :cards => fighter.deck.cards.select { |c| c.drawn? } })
      }
      
      xml.SummonedUnits{
        xml << render(:partial => 'layouts/card_struct', :locals => { :cards => fighter.deck.cards.select { |c| c.summoned? } })
      }
      
      xml.InactiveUnits{
        xml << render(:partial => 'layouts/card_struct', :locals => { :cards => fighter.deck.cards.select { |c| c.inactive? } })
      }
      
      xml.AttackingUnits{
		 xml << render(:partial => 'layouts/card_struct', :locals => { :cards => fighter.deck.cards.select { |c| c.attacking? } })
      }
      
      xml.Spells{
       xml << render(:partial => 'layouts/card_struct', :locals => { :cards => fighter.deck.cards.select { |c| c.casted? } })
      }
      
      xml.Cemetery{
        xml << render(:partial => 'layouts/card_struct', :locals => { :cards => fighter.deck.cards.select { |c| c.destroyed? } })
      }
    }
  end
}