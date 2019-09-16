# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    find_random_card
  end

  def edit; end

  private

  def find_random_card
    @cars_ids = Card.where('review_date < ?', DateTime.now).pluck('id')
    random_card_id = rand(0..(@cars_ids.length - 1))
    @card = Card.find(@cars_ids[random_card_id])
  end
end
