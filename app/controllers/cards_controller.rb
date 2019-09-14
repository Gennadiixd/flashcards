# frozen_string_literal: true

class CardsController < ApplicationController
  before_action :load_card, only: %i[show edit update destroy]

  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  def edit; end

  def update
    if @card.update(whitelisted_cards_params)
      redirect_to @card
    else
      render 'edit'
    end
  end

  def show; end

  def create
    @card = Card.new(whitelisted_cards_params)

    unless @card.review_date
      @card.review_date = (Time.now + 259_200).strftime('%Y-%m-%d %H:%M:%S')
    end

    if @card.save
      redirect_to @card
    else
      render 'new'
    end
  end

  def check_card
    @card_from_params = params[:card]
    @card_from_db = Card.find(session[:card]['id'])
    is_user_right = @card_from_db[:translated_text] == @card_from_params[:user_translated_text]
    if is_user_right
      @card_from_db[:review_date] = (Time.now + 259_200).strftime('%Y-%m-%d %H:%M:%S')
      @card_from_db.save
      msg = 'You are right!'
    else
      msg = 'Try again later'
    end
    redirect_to root_path, flash: { error: msg }
  end

  private

  def load_card
    @card = Card.find(params[:id])
  end

  def whitelisted_cards_params
    params.require(:card).permit(:original_text, :translated_text)
  end
end
