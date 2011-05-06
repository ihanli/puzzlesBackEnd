class CardInGamesController < ApplicationController
  def update
    card = CardInGame.find_by_id(params[:id])
    tmp_state = card.state
      
    case params[:event]
    when "get_ready"
      card.get_ready!
    when "draw"
      card.draw!
    when "summon"
      card.summon!
    when "deactivate"
      card.deactivate!
    when "cast"
      card.cast!
    when "attack"
      card.attack!
    when "destroy"
      card.destroy!
    when "remove_from_game"
      card.remove_from_game!
    end
    
    render :status => 418 unless tmp_state != card.state
  end
end
