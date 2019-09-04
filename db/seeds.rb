# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'nokogiri'

doc = Nokogiri.HTML(open('https://1000mostcommonwords.com/1000-most-common-german-words/'))

def number?(string)
  true if Float(string)
rescue StandardError
  false
end

dictionary = {}
item = nil
i = 3

doc.search('td').each do |td|
  unless number?(td.content)
    if i.positive?
      i -= 1
    elsif item
      dictionary[item] = td.content
      item = nil
    else
      item = td.content
    end
  end
end

dictionary.each do |key, value|
  Card.create!(
    original_text: key,
    translated_text: value,
    review_date: (Time.now + 259_200).strftime('%Y-%m-%d %H:%M:%S')
  )
end

puts 'Done'
