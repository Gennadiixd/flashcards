# frozen_string_literal: true

class Card < ApplicationRecord
  validates :original_text, :translated_text, :review_date, presence: true

  validate :original_and_translated_text

  def original_and_translated_text
    return unless original_text.casecmp?(translated_text)

    errors.add(:card, 'original and translated texts are equal')
  end
end
