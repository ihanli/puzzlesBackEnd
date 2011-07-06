class FightersController < ApplicationController
  before_filter :prepare_session

  def update
    if params[:fighter]
      fighter = Fighter.find_by_id(params[:id])
      update_flag = fighter.update_attributes(params[:fighter])
    end

    if params[:battle_id]
      fighters = Fighter.find_all_by_battle_id(params[:battle_id])
      toggle_flag = Fighter.toggle_state(fighters, params[:fbid])
    end

    if(params[:fighter] and !params[:battle_id]) or (!params[:fighter] and params[:battle_id])
      head 200 if update_flag or toggle_flag
    elsif params[:battle_id] and params[:fighter]
      head 200 if update_flag and toggle_flag
    else
      head 500
    end
	
	head 418 unless toggle_flag
  end
end
