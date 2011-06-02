class CardInGamesController < ApplicationController
  before_filter :prepare_session

  def create
  end

  def update
    card = CardInGame.find_by_id(params[:id])

    if card.transition_to(params[:event])
      head 200
    else
      head 418
    end
  end
end
