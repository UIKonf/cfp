# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

99.times do |_n|
  title = Faker::Hipster.sentence(word_count: 3)
  description = Faker::Markdown.sandwich(sentences: 5)
  Proposal.create!(title: title, description: description)
end
