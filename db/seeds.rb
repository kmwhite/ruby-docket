# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Team.create(name: 'Default Team')

if Rails.env.development? then
  require "faker"

  p = Project.create!(name: Faker::Company.catch_phrase, team_id: 1)
  u = User.where(email: 'docket@domain.com').first_or_create!(name: Faker::Name.name, team_id: 1, password: 'password')
  (1..5).each do |id|
    parent = Task.create!(name: Faker::Company.catch_phrase, project: p, reporter: u)
    child  = Task.create!(name: Faker::Company.catch_phrase, project: p, reporter: u, parent: parent)
    Task.create!(name: Faker::Company.catch_phrase, project: p, reporter: u, parent: child)
  end
end
