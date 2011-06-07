class BattlesController < ApplicationController

  before_filter :login_required
  before_filter :find_battle, :only => [:show, :destroy, :update]

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

  private
  def find_battle
    @battle = Battle.find_by_id(params[:id])
  end
end