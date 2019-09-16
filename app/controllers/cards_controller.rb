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
    @translated_text = Card.where(id: params[:card_id]).pluck(:translated_text).first
    is_user_right = @translated_text == @card_from_params[:user_translated_text]
    if is_user_right
      plus_three_days = (Time.now + 259_200).strftime('%Y-%m-%d %H:%M:%S')
      Card.update(params[:card_id], review_date: plus_three_days)
      flash_msg = { success: 'You are right!' }
    else
      flash_msg = { error: 'Try again later' }
    end
    redirect_to root_path, flash: flash_msg
  end

  private

  def load_card
    @card = Card.find(params[:id])
  end

  def whitelisted_cards_params
    params.require(:card).permit(:original_text, :translated_text)
  end
end
