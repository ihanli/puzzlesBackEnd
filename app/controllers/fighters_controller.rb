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

    fighters.each do |fighter|
      tmp_state = fighter.state

      case params[:event]
      when "proceed" || "wait"
        #TODO: give id of logged in user as parameter
        if fighter.user.fb_id == params[:user_id]
          fighter.wait!
        else
          fighter.proceed!
        end
      when "finish"
        fighter.finish!
      end
      
      render :status => 418 unless tmp_state != fighter.state
    end
  end
end
