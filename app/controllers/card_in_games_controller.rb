class CardInGamesController < ApplicationController
  def update
    card = CardInGame.find_by_id(params[:id])
    render :status => 418 unless card.transition_to(params[:event])
  end
end
