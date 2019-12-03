# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

#   spinner = Enumerator.new do |e|
#   loop do
#     e.yield '.'
#     e.yield ' o'
#     e.yield '  O'
#     e.yield '   0'
#     e.yield '    O'
#     e.yield '     o'
#     e.yield '      .'
#     e.yield '     o'
#     e.yield '    O'
#     e.yield '   0'
#     e.yield '  O'
#     e.yield ' o'
#   end
# end

# 1.upto(100) do |i|
#   printf("\rBooting... %s", spinner.next)
#   sleep(0.1)
# end

print "Destroying all teams..."
Team.destroy_all
puts "Successfull.. next"
puts "Destroying all players..."
Person.destroy_all
puts "Successfull... next"

team_endpoint = 'https://data.nba.net/'

uri = URI(team_endpoint)
response = Net::HTTP.get(uri)
res = JSON.parse(response)
# res['b_path'].each { |h| h.delete('id') }


all_teams = {}

res['sports_content']['teams']['team'].each do |team|
  team_name = team['team_name']
  team_nickname = team['team_nickname']
  team_abbreviation = team['team_abbrev']
  team_city = team['city']
  team_state = team['state']
  team_id = team['team_id']
  is_nba = team['is_nba_team']

  puts "creating teams..."

  team = Team.create!(name: team_name, nickname: team_nickname, city: team_city, state: team_state, abbrevation: team_abbreviation) if is_nba
  all_teams[team_id.to_s] = team
end

puts "Successfull... next"

url = 'https://data.nba.net/10s/prod/v1/2019/players.json'
uri = URI(url)
response = Net::HTTP.get(uri)
res = JSON.parse(response)

res['league']['standard'].each do |person|
  first_name = person['firstName']
  last_name = person['lastName']
  api_team = person['teamId']
  jersey = person['jersey']
  position = person['pos']
  height = person['heightMeters']


  # p [ first_name, last_name, api_team, jersey, position, height]

  team = all_teams[api_team]

  player = Person.new(first_name: first_name, last_name: last_name,jersey_number: jersey, position: position, height: height)
  player.team = team
  player.save
end

puts "Successfull... done!"
