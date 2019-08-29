# frozen_string_literal: true

class Card < ApplicationRecord
  validates :original_text, :translated_text, :review_date, presence: true

  validate :original_and_translated_text

  before_validation do
    self.review_date = (Time.now + 259_200).strftime('%Y-%m-%d %H:%M:%S')
  end

  def original_and_translated_text
    errors.add(:card, "original and translated text can't be the same") if original_text.casecmp == translated_text.casecmp
  end
end
