class BattlesController < ApplicationController
  before_filter :find_battle, :only => [:show, :destroy, :update]

  #TODO: implement actions to switch between states

  def index
    #TODO: give id of logged in user as parameter

    @battles = Battle.get_battles_by_user(params[:fb_id])

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
    battle = Battle.new(params[:battle])
    if battle.save
      redirect_to :controller => "fighters", :action => "create", :fighter => params[:fighter]
    else
      head 500
    end
  end

  def update
    head 500 unless @battle.pending?

    @battle.start!
    redirect_to :controller => "fighter", :action => "create", :fighter => params[:fighter]
  end

  def destroy
    redirect_to battles_path if @battle.destroy
  end

  protected
  def find_battle
    @battle = Battle.find_by_id(params[:id])
  end
end