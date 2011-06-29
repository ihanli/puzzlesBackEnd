class DecksController < ApplicationController
  before_filter :find_deck, :only => [:show, :destroy]

  def index
    @decks = Deck.find_decks_by_user(session[:fbid])

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
    redirect_to deck_path(@deck.id) if @deck.save
  end

  def update
    head 418 unless @deck.change_state
    head 200
  end

  def destroy
    redirect_to decks_path if @deck.destroy
  end

  protected
  def find_deck
    @deck = Deck.find_by_id(params[:id])
  end
end
