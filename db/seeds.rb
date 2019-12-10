require 'open-uri'
require 'json'

print "Destroying all teams"
Team.destroy_all
puts "Destroying all players"
Person.destroy_all

puts "creating teams"
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
  is_nba = team['is_nba_team']

  team = Team.create!(name: team_name, nickname: team_nickname, city: team_city, state: team_state, abbrevation: team_abbreviation, api_team_id: team_id) if is_nba
  all_teams[team_id.to_s] = team
end


puts "Creating standings data"

standings_data = HTTParty.get("http://data.nba.net/10s/prod/v1/current/standings_conference.json")

standings_data["league"]["standard"]["conference"]["east"].each do |rank|
  team = Team.find_by(abbrevation: rank["teamSitesOnly"]["teamTricode"])
  team.conference = "east"
  team.standing = rank["confRank"]
  team.win_percent = rank["winPct"]
  team.games_behind = rank["gamesBehind"]
  team.conf_win = rank["confWin"]
  team.conf_loss = rank["confLoss"]
  team.last10wins = rank["lastTenWin"]
  team.last10loss = rank["lastTenLoss"]
  team.streak = rank["streak"]
  team.streak_wins = rank["isWinStreak"]
  team.save
end

standings_data["league"]["standard"]["conference"]["west"].each do |rank|
  team = Team.find_by(abbrevation: rank["teamSitesOnly"]["teamTricode"])
  team.conference = "west"
  team.standing = rank["confRank"]
  team.win_percent = rank["winPct"]
  team.games_behind = rank["gamesBehind"]
  team.conf_win = rank["confWin"]
  team.conf_loss = rank["confLoss"]
  team.last10wins = rank["lastTenWin"]
  team.last10loss = rank["lastTenLoss"]
  team.streak = rank["streak"]
  team.streak_wins = rank["isWinStreak"]
  team.save
end

# Sample query
# Team.find_by(standing: 3, conference: "west")

puts "getting player data"
puts "this may take some time...."

player_data = HTTParty.get('https://data.nba.net/10s/prod/v1/2019/players.json')
player_data['league']['standard'].each do |person|
  first_name = person['firstName']
  last_name = person['lastName']
  api_team = person['teamId']
  player_id = person['personId']
  jersey = person['jersey']
  position = person['pos']
  height = person['heightMeters']

  team = all_teams[api_team]

  # if Person.find_by(player_id: player_id).nil?
  player = Person.create(first_name: first_name, last_name: last_name, jersey_number: jersey, position: position, height: height, team_id: api_team, player_id: player_id)
  player_photo_url = "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/#{player.team_id}/2019/260x190/#{player.player_id}.png"
  response = Net::HTTP.get_response(URI.parse(player_photo_url))
  if response.code == "200"
    player.remote_photo_url = player_photo_url
  else
    player.remote_photo_url = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRh49ijhQi31DXh6lbhU4EQdivzB42Gdgwgd704DhfFXwdaZHLO&s"
  end
  player.team = team
  player.save
  # end
end


puts "creating 6 users"
a = User.create!(email: "test@test.com", password: "123456")
b = User.create!(email: "ron@aol.com", password: "123456")
c = User.create!(email: "josh@bros.com", password: "123456")
d = User.create!(email: "arnie@gmail.com", password: "123456")
e = User.create!(email: "ron@Artenstein.com", password: "123456")
f = User.create!(email: "aaron@blue.com", password: "123456")

user_list = [a, b, c, d, e, f]

puts "creating sample team followers"
20.times do
  user_list.sample.follow(Team.all.sample)
end

puts "creating sample player followers"
20.times do
  user_list.sample.follow(Person.all.sample)
end

a.follow(Person.find(241))

puts "creating 5 posts"
Post.create!(user_id: 1, title: "LeBron is the GOAT", user_generated: true, likes: 10008, content: "Lorem ipsum dolor
  sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
  Ac felis donec et odio pellentesque. Tristique et egestas quis ipsum suspendisse ultrices gravida
  dictum fusce. Consequat interdum varius sit amet mattis vulputate enim nulla aliquet. Nulla pharetra
  diam sit amet nisl suscipit adipiscing bibendum. Faucibus in ornare quam viverra. Nunc consequat interdum
  arius sit amet mattis vulputate. Lorem ipsum dolor sit amet consectetur. Duis at consectetur lorem donec
  massa. Diam vel quam elementum pulvinar etiam non quam. Neque gravida in fermentum et sollicitudin ac. Est
  ante in nibh mauris cursus.", category: "Person", people_id: 241)

Post.create!(user_id: 2, title: "Nobody like Jordan", user_generated: true, likes: 3, content: "Praesent
  elementum facilisis leo vel fringilla est ullamcorper eget nulla. Non diam phasellus vestibulum lorem sed
  sus. Luctus venenatis lectus magna fringilla urna porttitor. Elementum nisi quis eleifend quam adipiscing
  vitae proin. Velit sed ullamcorper morbi tincidunt ornare massa. Nisl pretium fusce id velit ut tortor
  pretium viverra. Amet commodo nulla facilisi nullam vehicula ipsum a arcu cursus. Congue quisque egestas
  diam in arcu cursus euismod quis viverra. In metus vulputate eu scelerisque felis. Pellentesque dignissim
  enim sit amet venenatis urna cursus eget nunc. Lorem dolor sed viverra ipsum nunc aliquet bibendum.",
  category: "Team",)

Post.create!(user_id: 3, title: "My mom said yuo can't come over today", user_generated: true, likes: 0,
  content: "Magna sit amet purus gravida quis blandit turpis cursus. Vulputate enim nulla aliquet porttitor
  cus luctus. Nisl nisi scelerisque eu ultrices vitae auctor eu augue ut. Odio pellentesque diam volutpat
  commodo sed egestas. Velit dignissim sodales ut eu.", category: "Team")

Post.create!(user_id: 4, title: "Larry Nance is my dad", user_generated: true, likes: 42, content: "Mattis
  llentesque id nibh tortor id aliquet lectus proin nibh. Libero enim sed faucibus turpis in. Hendrerit
  dolor magna eget est lorem ipsum dolor. In ornare quam viverra orci sagittis eu volutpat. Tellus mauris
  a diam maecenas sed enim ut sem. Pharetra vel turpis nunc eget lorem dolor. Amet risus nullam eget felis
  get nunc lobortis mattis aliquam. Enim facilisis gravida neque convallis a cras semper auctor neque. At
  elementum eu facilisis sed odio morbi quis commodo odio. Augue eget arcu dictum varius. Velit aliquet s
  agittis id consectetur. Pharetra vel turpis nunc eget lorem dolor sed viverra. Quam lacus suspendisse
  faucibus interdum posuere lorem. Feugiat nibh sed pulvinar proin gravida hendrerit.", category: "Person")

Post.create!(user_id: 5, title: "Baseketball Sucks, change my mind", user_generated: true, likes: 9001,
  content: "One morning, when Gregor Samsa woke from troubled dreams, he found himself transformed in his
  bed into a horrible vermin. He lay on his armour-like back, and if he lifted his head a little he could
  see his brown belly, slightly domed and divided by arches into stiff sections. The bedding was hardly able
  to cover it and seemed ready to slide off any moment. His many legs, pitifully thin compared with the size
  of the rest of him, waved about helplessly as he looked. \"What's happened to me?\" he thought. It wasn't
  a dream. His room, a proper human room although a little too small, lay peacefully between its four familiar
  walls.", category: "Person")

puts "getting all game score data"
puts "this may take some time...."

def date_to_string(date_object)
  "#{date_object.year}#{format('%02i', date_object.month)}#{format('%02i', date_object.day)}"
end

def string_to_date(date_string)
  Date.new(date_string[0...4].to_i, date_string[4...6].to_i, date_string[6...8].to_i)
end


# --------- Get from Online --------- #
def get_days_scores_api(date_string)
  score_url = "http://data.nba.net/10s/prod/v1/#{date_string}/scoreboard.json"
  data = HTTParty.get(score_url)
  data["games"].each do |game|
    box = Game.new
    box.date = date_string
    visiting_team = Team.find_by(abbrevation: game["vTeam"]["triCode"])
    home_team = Team.find_by(abbrevation: game["hTeam"]["triCode"])
    box.vTeam_id = visiting_team.id
    box.hTeam_id = home_team.id
    box.vTeamScore = game["vTeam"]["score"]
    box.hTeamScore = game["hTeam"]["score"]
    if game["vTeam"]["linescore"][0].nil? == false
      box.vteam_q1 = game["vTeam"]["linescore"][0]["score"]
      box.vteam_q2 = game["vTeam"]["linescore"][1]["score"]
      box.vteam_q3 = game["vTeam"]["linescore"][2]["score"]
      box.vteam_q4 = game["vTeam"]["linescore"][3]["score"]
      box.hteam_q1 = game["hTeam"]["linescore"][0]["score"]
      box.hteam_q2 = game["hTeam"]["linescore"][1]["score"]
      box.hteam_q3 = game["hTeam"]["linescore"][2]["score"]
      box.hteam_q4 = game["hTeam"]["linescore"][3]["score"]
    end
    box.save

    visiting_team.wins = game["vTeam"]["win"]
    visiting_team.losses = game["vTeam"]["loss"]
    home_team.wins = game["hTeam"]["win"]
    home_team.losses = game["hTeam"]["loss"]
    visiting_team.save
    home_team.save
  end
end

def get_season_score
  season_start = Time.new(2019, 10, 22)
  today = Time.now
  days = ((today - season_start) / 86_400).to_i
  days.times do |day|
    date_string = date_to_string(season_start + (day * 86_400))
    get_days_scores_api(date_string)
  end
end

get_season_score

puts "done"

# --------- Get to/from Local --------- #

# def days_scores_to_file(date_string)
#   score_url = "http://data.nba.net/10s/prod/v1/#{date_string}/scoreboard.json"
#   data = HTTParty.get(score_url)
#   data_array = []
#   data["games"].each do |game|
#     data_array < game
#   end
#   append_api(data_array)
# end

# def append_api(game_hash)
#   data_from_json = JSON[File.read("db/game_data.json")]
#   File.open("./db/game_data.json","w") do |f|
#     f.write(JSON.pretty_generate(data_from_json << game_hash))
#   end
# end

# def load_local_score
#   source = File.open("db/game_data.json")
#   data = JSON.parse(source.read)
#   data["games"].each do |game|
#     box = Game.new
#     box.date = date_string
#     box.vTeam_id = Team.find_by(abbrevationJSON: game["vTeam"]["triCode"]).id
#     box.vTeamScore = game["vTeam"]["score"]
#     box.hTeam_id = Team.find_by(abbrevation: game["hTeam"]["triCode"]).id
#     box.hTeamScore = game["hTeam"]["score"]
#     box.save
#   end
# end
