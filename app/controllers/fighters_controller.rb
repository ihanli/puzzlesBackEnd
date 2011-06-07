class FightersController < ApplicationController
#  TODO: refactor me!
  def create
    fighter = Fighter.new(params[:fighter])

    if fighter.save
      fighters = Fighter.find_all_by_battle_id(fighter.battle_id)

#      if fighters.count == 2
#        fighters.each do |fighter|
#          cards = Card.find_cards_by_user(fighter.user.id)
#
#          cards.each do |card|
#            CardInGame.create({ :fighter_id => fighter.id, :card_id => card.id, :attack => card.attack, :health => card.health })
#          end
#
#          fighter.deck.change_state
#        end
#      end

      if fighters.count > 2
        head 500
      else
        redirect_to battle_path(fighter.battle_id)
      end
    else
      head 500
    end
  end

  def update
    if params[:fb_id]
      fighter = Fighter.find_by_fbid(params[:fb_id])
      update_flag = fighter.update_attributes(params[:fighter])
    end

    if params[:battle_id]
      fighters = Fighter.find_all_by_battle_id(params[:battle_id])
      toggle_flag = fighters.toggle_state
    end

    if (params[:fb_id] and !params[:battle_id]) or (!params[:fb_id] and params[:battle_id])
      head 200 if update_flag or toggle_flag
    elsif params[:battle_id] and params[:fb_id]
      head 200 if update_flag and toggle_flag
    else
      head 500
    end
  end
end
