class UsersController < ApplicationController
  before_filter :prepare_session, :except => [:show, :destroy]
  before_filter :find_user, :only => [:show, :destroy]

  def show
    respond_to do |format|
      format.xml
    end
  end

  def create
    user = User.new(params[:user])
    if user.save
      redirect_to user_path(user.id)
    else
      head 500
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_path
    else
      head 500
    end
  end

  def register_and_login
    unless User.find_by_fb_id(params[:id])
      user = User.create(:fb_id => params[:id])
      create_default_deck(user.id)
    end

    session[:fbid] = params[:id]
    session[:expiry_time] = MAX_SESSION_TIME.seconds.from_now
    head 200
  end

  protected
  def find_user
    @user = User.find_by_id(params[:id])
  end
  
  def create_default_deck(user_id)
    deck = Deck.create(:name => "Starter Deck")
    abstract_cards = AbstractCard.all
    
    abstract_cards.each do |abstract_card|
      card = Card.create(:abstract_card_id => abstract_card.id, :user_id => user_id, :puzzles => 0, :decks => [deck])
    end
  end
end