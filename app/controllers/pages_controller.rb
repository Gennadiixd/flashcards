# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    find_random_card
  end

  def check_card
    @card = params[:card]
    is_user_right = session[:translated_text] == @card[:user_translated_text]
    if is_user_right
      @card.review_date = (Time.now + 259_200).strftime('%Y-%m-%d %H:%M:%S')
      @card.save
    else
      @card.errors.add(:translated_text, 'Not valid')
    end
    find_random_card
    redirect_to root_path
  end

  def edit; end

  def find_random_card
    @cars_ids = Card.where('review_date > ?', DateTime.now).pluck('id')
    random_card_id = rand(0..(@cars_ids.length - 1))
    @card = Card.find(@cars_ids[random_card_id])
    session[:translated_text] = @card.translated_text
  end
end
