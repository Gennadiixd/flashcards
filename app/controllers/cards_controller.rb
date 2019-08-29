# frozen_string_literal: true

class CardsController < ApplicationController

  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy
    redirect_to cards_path
  end

  def edit
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])

    if @card.update(whitelisted_cards_params)
      redirect_to @card
    else
      render 'edit'
    end
  end

  def show
    @card = Card.find(params[:id])
  end

  def create
    @card = Card.new(whitelisted_cards_params)

    if @card.save
      redirect_to @card
    else
      render 'new'
    end
  end

  private

  def whitelisted_cards_params
    params.require(:card).permit(:original_text, :translated_text)
  end

end
