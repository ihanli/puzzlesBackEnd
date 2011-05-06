xml.instruct!
xml.Battle(:id => @battle.id){
  @battle.fighters.each do |fighter|
    xml.Fighter(:state => fighter.state, :mana => fighter.mana, :health => fighter.health){
      xml.fb_id(fighter.user.fb_id)
            
      xml.Deck{
        xml << render(:partial => 'card_in_games_struct', :locals => { :cards => fighter.card_in_games.select { |c| c.ready_to_play? } })
      }
      
      xml.Hand{
        xml << render(:partial => 'card_in_games_struct', :locals => { :cards => fighter.card_in_games.select { |c| c.drawn? } })
      }
      
      xml.Units{
        xml << render(:partial => 'card_in_games_struct', :locals => { :cards => fighter.card_in_games.select { |c| c.summoned? || c.inactive? || c.attacking? } })
      }
      
      xml.Spells{
       xml << render(:partial => 'card_in_games_struct', :locals => { :cards => fighter.card_in_games.select { |c| c.casted? } })
      }
      
      xml.Cemetery{
        xml << render(:partial => 'card_in_games_struct', :locals => { :cards => fighter.card_in_games.select { |c| c.destroyed? } })
      }
    }
  end
}