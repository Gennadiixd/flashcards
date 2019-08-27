# frozen_string_literal: true

class PagesController < ApplicationController
  def index; end

  def all_cards
    @cards = Card.all
  end

  def add_card; end
end
