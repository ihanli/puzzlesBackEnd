class FightersController < ApplicationController
  def create
    fighter = Fighter.new(params[:fighter])
      
    if fighter.save
      fighters = Fighter.find_all_by_battle_id(fighter.battle_id)
      
      if fighters.count == 2
        fighters.each do |fighter|
          cards = Card.find_cards_by_user(fighter.user.id)
          
          cards.each do |card|
            CardInGame.new({ :fighter_id => fighter.id, :card_id => card.id, :attack => card.attack, :health => card.health }).save
          end
          
          fighter.deck.change_state
        end
      end

      head 500 if fighters.count > 2
      redirect_to battle_path(fighter.battle_id)
    end
    
    head 500
  end

  def update
    fighters = Fighter.get_fighters_by_battle(params[:battle_id])
    head 418 unless fighters.transition_to(params[:event])
    head 200
  end
end
