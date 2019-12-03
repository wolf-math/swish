require 'open-uri'
require 'json'

  spinner = Enumerator.new do |e|
  loop do
    e.yield '.'
    e.yield ' o'
    e.yield '  O'
    e.yield '   0'
    e.yield '    O'
    e.yield '     o'
    e.yield '      .'
    e.yield '     o'
    e.yield '    O'
    e.yield '   0'
    e.yield '  O'
    e.yield ' o'
  end
end

1.upto(100) do |i|
  printf("\rBooting... %s", spinner.next)
  sleep(0.1)
end

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

all_teams = {}

res['sports_content']['teams']['team'].each do |team|
  team_name = team['team_name']
  team_nickname = team['team_nickname']
  team_abbreviation = team['team_abbrev']
  team_city = team['city']
  team_state = team['state']
  team_id = team['team_id']

  puts "creating teams..."

  team = Team.create!(name: team_name, nickname: team_nickname, city: team_city, state: team_state, abbrevation: team_abbreviation)
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

  team = all_teams[api_team]

  player = Person.new(first_name: first_name, last_name: last_name,jersey_number: jersey, position: position, height: height)
  player.team = team
  player.save
end

puts "creating 4 users..."
a = User.create!(email:"test@test.com", password: "123456")
b = User.create!(email:"ron@aol.com", password: "123456")
c = User.create!(email:"josh@bros.com", password: "123456")
d = User.create!(email:"arnie@gmail.com", password: "123456")
e = User.create!(email:"ron@Artenstein.com", password: "123456")

user_list = [a, b, c, d, e]

20.times do
  user_list.sample.follow(Team.find(1...36))
end

20.times do
  user_list.sample.follow(Person.find(1...36))
end

puts "creating 10 posts..."
Post.create!(user_id: 1, title: "LeBron is the GOAT", user_generated: true, likes: 10008, content: "Lorem ipsum dolor
  sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
  Ac felis donec et odio pellentesque. Tristique et egestas quis ipsum suspendisse ultrices gravida
  dictum fusce. Consequat interdum varius sit amet mattis vulputate enim nulla aliquet. Nulla pharetra
  diam sit amet nisl suscipit adipiscing bibendum. Faucibus in ornare quam viverra. Nunc consequat interdum
  arius sit amet mattis vulputate. Lorem ipsum dolor sit amet consectetur. Duis at consectetur lorem donec
  massa. Diam vel quam elementum pulvinar etiam non quam. Neque gravida in fermentum et sollicitudin ac. Est
  ante in nibh mauris cursus.", category: "Clevenad Cavs")

Post.create!(user_id: 2, title: "Nobody like Jordan", user_generated: true, likes: 3, content: "Praesent
  elementum facilisis leo vel fringilla est ullamcorper eget nulla. Non diam phasellus vestibulum lorem sed
  sus. Luctus venenatis lectus magna fringilla urna porttitor. Elementum nisi quis eleifend quam adipiscing
  vitae proin. Velit sed ullamcorper morbi tincidunt ornare massa. Nisl pretium fusce id velit ut tortor
  pretium viverra. Amet commodo nulla facilisi nullam vehicula ipsum a arcu cursus. Congue quisque egestas
  diam in arcu cursus euismod quis viverra. In metus vulputate eu scelerisque felis. Pellentesque dignissim
  enim sit amet venenatis urna cursus eget nunc. Lorem dolor sed viverra ipsum nunc aliquet bibendum.",
  category: "Chicago Bulls")

Post.create!(user_id: 3, title: "Basketball sucks, change my mind", user_generated: true, likes: 0,
  content: "Magna sit amet purus gravida quis blandit turpis cursus. Vulputate enim nulla aliquet porttitor
  cus luctus. Nisl nisi scelerisque eu ultrices vitae auctor eu augue ut. Odio pellentesque diam volutpat
  commodo sed egestas. Velit dignissim sodales ut eu.", category: "troll")

Post.create!(user_id: 4, title: "Larry Nance is my dad", user_generated: true, likes: 42, content: "Mattis
  llentesque id nibh tortor id aliquet lectus proin nibh. Libero enim sed faucibus turpis in. Hendrerit
  dolor magna eget est lorem ipsum dolor. In ornare quam viverra orci sagittis eu volutpat. Tellus mauris
  a diam maecenas sed enim ut sem. Pharetra vel turpis nunc eget lorem dolor. Amet risus nullam eget felis
  get nunc lobortis mattis aliquam. Enim facilisis gravida neque convallis a cras semper auctor neque. At
  elementum eu facilisis sed odio morbi quis commodo odio. Augue eget arcu dictum varius. Velit aliquet s
  agittis id consectetur. Pharetra vel turpis nunc eget lorem dolor sed viverra. Quam lacus suspendisse
  faucibus interdum posuere lorem. Feugiat nibh sed pulvinar proin gravida hendrerit.", category: "family")


puts "Successfull... done!"
