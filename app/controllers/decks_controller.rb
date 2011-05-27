class DecksController < ApplicationController
  before_filter :find_deck, :only => [:show, :destroy]

  def index
    #TODO: give id of logged in user as parameter

    @decks = Deck.get_decks_by_user(params[:user_id])

    respond_to do |format|
      format.xml
    end
  end

  def show
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
    render :status => 418 unless @deck.change_state
  end

  def destroy
    if @deck.destroy
      redirect_to decks_path
    end
  end

  protected
  def find_deck
    @deck = Deck.find_by_id(params[:id])
  end
end
