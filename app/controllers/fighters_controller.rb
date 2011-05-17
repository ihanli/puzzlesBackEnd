class FightersController < ApplicationController
  def create
    @fighter = Fighter.new(params[:fighter])

    if @fighter.save
      redirect_to battle_path(@fighter.battle_id)
    else
      render :status => 500
    end
  end

  def update
    fighters = Fighter.get_fighters_by_battle(params[:battle_id])
    render :status => 418 unless fighters.transition_to(params[:event])
  end
end
