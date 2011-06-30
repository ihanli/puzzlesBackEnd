class BattlesController < ApplicationController
  before_filter :find_battle, :only => [:show]

  def index
    @battles = Battle.get_battles_by_user(session[:fbid])

    respond_to do |format|
      format.xml
    end
  end

  def show
    respond_to do |format|
      format.xml
      format.html
    end
  end

  def create
    battle = Battle.new(:rid => params[:rid])
    if battle.save
      battle = Battle.find_by_rid(params[:rid])
      user = User.find_by_fb_id(params[:fbid])
      fighter = Fighter.new(:user_id => user.id, :battle_id => battle.id, :deck => user.cards.first.decks.first)
      head 500 unless fighter.save
      fighter.proceed!
    else
      head 500
    end
    
    head 200
  end

  def update
    battle = Battle.find_by_rid(params[:rid])

    head 500 unless battle.pending?

    battle.start!
    user = User.find_by_fb_id(params[:fbid])
    fighter = Fighter.new(:user_id => user.id, :battle_id => battle.id, :deck => user.cards.first.decks.first)
    head 500 unless fighter.save
    fighter.wait!
    head 200
  end

  def destroy
    battle = Battle.find_by_rid(params[:rid])
    head 500 unless battle.delete
    head 200
  end

  private
  def find_battle
    @battle = Battle.find_by_id(params[:id])
  end
end