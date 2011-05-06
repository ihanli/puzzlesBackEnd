class FightersController < ApplicationController
  def create
    @fighter = Fighter.new(params[:fighter])
      
    if @fighter.save
      redirect_to battle_path(@fighter.battle_id)
    else
      render :status => 500
    end
  end
  
  def begin
    #TODO: give id of logged in user as parameter
    fighter = Fighter.find_by_user_id(params[:user_id])
    fighter.proceed!
  end
  
  def end_turn
    fighters = Fighter.get_fighters_by_battle(params[:id])
      
    fighters.each do |fighter|
      #TODO: give id of logged in user as parameter
      if fighter.user.fb_id == params[:user_id]
        fighter.proceed!
      else
        fighter.wait!
      end
    end
  end
end
