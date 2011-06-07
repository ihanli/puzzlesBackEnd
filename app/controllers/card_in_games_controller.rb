class CardInGamesController < ApplicationController
  def update
    card = CardInGame.find_by_id(params[:id])

    if params[:event]
      if card.transition_to(params[:event])
        head 200
      else
        head 418
      end
    else
      card.use_talent
    end
  end
end
