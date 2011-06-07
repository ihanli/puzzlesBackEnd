class CardInGamesController < ApplicationController
  def update
    @card = CardInGame.find_by_id(params[:id])

    if params[:event]
      if @card.transition_to(params[:event])
        head 200
      else
        head 418
      end
    else
      @card.use_talent
      
      respond_to do |format|
        format.xml
      end
    end
  end
end
