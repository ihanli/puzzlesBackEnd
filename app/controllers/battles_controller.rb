class BattlesController < ApplicationController
  before_filter :find_battle, :only => [:show, :destroy]

  #TODO: implement actions to switch between states

  def index
    #TODO: give id of logged in user as parameter

    @battles = Battle.get_battles_by_user(params[:user_id])

    respond_to do |format|
      format.xml
    end
  end

  def show
    #front end should start/continue battle if show action is called
    respond_to do |format|
      format.xml
      format.html
    end
  end

  def create
    @battle = Battle.new(params[:battle])

    if @battle.save
      redirect_to battle_path(@battle.id)
    end
  end

  def destroy
    if @battle.destroy
      redirect_to battles_path
    end
  end

  protected
  def find_battle
    @battle = Battle.find_by_id(params[:id])
  end
end
