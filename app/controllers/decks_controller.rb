class DecksController < ApplicationController
  def index
    #TODO: give id of logged in user as parameter
    
    @decks = Deck.get_decks_by_user(params[:user_id])
      
    respond_to do |format|
      format.xml
    end
  end
  
  def show
    @deck = Deck.find(params[:id])
      
    respond_to do |format|
      format.xml
    end
  end
  
  def create
    @deck = Deck.new(params[:deck])
      
    if @deck.save
      redirect_to deck_path(@deck.id)
    end
  end
  
  def update
    deck = Deck.find_by_id(params[:id])
    tmp_state = deck.state
      
    unless deck.cards.first.card_in_games
      deck.free!
    else
      deck.occupy!
    end
    
   # render :status => 418 unless tmp_state != deck.state
  end
  
  def destroy
    @deck = Deck.find(params[:id])
      
    if @deck.destroy
      redirect_to decks_path
    end
  end
end
