class BattlesController < ApplicationController
 # before_filter :login_required
  before_filter :find_battle, :only => [:show, :destroy]

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
      user = User.find_by_fb_id(params[:fbid])
      fighter = Fighter.new(:user_id => user.id, :battle_id => battle.id, :deck_id => Deck.find_decks_by_user(user.id).first)
      head 500 unless fighter.save
    else
      head 500
    end
  end

  def update
    battle = Battle.find_by_rid(params[:rid])

    head 500 unless battle.pending?

    battle.start!
    user = User.find_by_fb_id(params[:fbid])
    fighter = Fighter.new(:user_id => user.id, :battle_id => battle.id, :deck_id => Deck.find_decks_by_user(user.id).first)
    head 500 unless fighter.save
  end

  def destroy
    redirect_to battles_path if @battle.destroy
  end

  private
  def find_battle
    @battle = Battle.find_by_id(params[:id])
  end
end