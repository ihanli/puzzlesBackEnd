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
  
  def destroy
    @deck = Deck.find(params[:id])
      
    if @deck.destroy
      redirect_to decks_path
    end
  end
end
