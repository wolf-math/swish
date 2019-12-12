require 'open-uri'
require 'json'

puts "Destroying all games"
Game.destroy_all
puts "Destroying all comments"
Comment.destroy_all
puts "Destroying all posts"
Post.destroy_all
puts "Destroying all players"
Person.destroy_all
puts "Destroying all teams"
Team.destroy_all
puts "Destroying all users"
User.destroy_all


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

############### Sample query ##############
########### Team.find_by(standing: 3, conference: "west") #########


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

  player = Person.create(first_name: first_name, last_name: last_name, jersey_number: jersey, position: position, height: height, team_id: api_team, player_id: player_id)

  # player_photo_url = "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/#{player.team_id}/2019/260x190/#{player.player_id}.png"
  # response = Net::HTTP.get_response(URI.parse(player_photo_url))
  # if response.code == "200"
  #   player.remote_photo_url = player_photo_url
  # else
  #   player.remote_photo_url = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRh49ijhQi31DXh6lbhU4EQdivzB42Gdgwgd704DhfFXwdaZHLO&s"
  # end
  player.team = team
  player.save
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
30.times do
  user_list.sample.follow(Person.all.sample)
end





puts "creating 5 posts"

Post.create!(user_id: 1, title: "LeBron is the GOAT", user_generated: true, likes: 10008, content: "Lebron
James is the greatest basketball player of all time.

Most talented? That goes to Jordan. But best overall player? Lebron JAMES. LeGOAT.

3 rings. 1 ring he got by being down 3-1 against one of the best teams in basketball history.

8 straight finals. I understand it’s the east, but he went to 8 STRAIGHT. Even without Kyrie, and a weak roster,
he made it to the finals.

Look at the cavaliers after Lebron West. They went from the BEST TEAM IN THE EAST TO THE WORST TEAM IN THE EAST
WITH JUST LOSING ONE PLAYER.

He’s also been the best player in the league for 14 YEARS. He’s 34 (and while he did get injured) and is still
the best basketball or one of the best in the world.",
 )
Post.create!(title: "Jordan is the GOAT", content: "For one,
 he’s first in points per game even though he’s not first in total points considering he took a few years
 off here and there.
 He’s even ahead of wilt chamberlain, who averaged 50 ppg one season. He also has 14
  all star appearances and 5 mvps and even has a defensive player of the year award, one of three guards
in history to win it.

There’s also the fact that he’s 6-0 in the finals. People will say that he’s only 6-0 because he sometimes
 lost earlier in the playoffs and didn’t make it to the finals, but that’s a bad argument because while he’s
 still been to less finals than Lebron, he’s won twice as many.
  It would be a different story if Lebron was
 6-3 and Jordan was 6-0 because then Lebron would have the edge but to me, total championships outweighs finals
  appearances.
  He also accomplished this while remaining on the same team the whole time, and it’s notable that
  he prevented other all time players like Barkley, Ewing etc from winning a ring.
   He won FMVP in every one of
  these finals as well.

Finally, he’s the most iconic player.
 He has a number of highlights that even casual fans are familiar with,
 his sneaker brand is the most famous basketball sneaker in the world, and he and the nba rose to popularity
 at the same time. He has the career achievements, legacy, clutch moments and by now he’s pretty much legend
 status with his shoe and his perfect finals record.
  Whether or not these all matter to you is up to you but
  these reasons are why many consider him the greatest.",)

Post.create!(user_id: 3, title: "Luka is going to be the MVP ", user_generated: true, likes: 0,
  content: "So far in 2019, Luka is also leading the NBA in PER (player efficiency rating) at 33.5. The two
  closest to him are the two most recent MVPs in Giannis Antetokounmpo and James Harden. He leads them both
   by more than a point. If you still aren’t buying into the Luka hype, he has the best PER for a season in
    NBA history using his numbers so far.
he became the second player in NBA history to record 2,000 points, 500 rebounds, and 500 assists before their
 90th career game.
 It took Doncic 88 games. To add some perspective, the only person to do it faster was Oscar Robinson,
  who did it in 66 games..", category: "Team")

Post.create!(user_id: 4, title: "Why i hate James Harden", user_generated: true, likes: 42, content: "Harden
 exploits the current set of rules surrounding fouls on an offensive player driving to the basket.
  Harden
 incredibly adept at attacking the basket and drawing contact with opposing players while he does so.

His penchant for doing this has received immense amounts of criticism and subsequent hatred by his peers,
 basketball fans, and media members alike.
 Can it be frustrating that he has found a way to excellent at exploiting
 a flawed system? Yes, absolutely, yet Harden receives the flack for it.", category: "Person")

Post.create!(user_id: 5, title: "Zion the new and improved Barkley", user_generated: true, likes: 9001,
  content: "Zion is a once in a lifetime athlete, we have never seen someone at his frame be able to move the way
  he does, especially vertically.
   He has absolutely elite explosive ability, open court speed, and great quickness
   for his size as well.
    His strength, acceleration, and coordination are all superb as well.
     This is apparent to
    anyone who watches a few plays of his, and it has been apparent since he was first noticed in high school.
    He will
     enter the NBA as a top 5 athlete in the league, and will likely be the best athlete in the league at times during
     his career.

Zion's all-world athleticism often allows him to explode through contact at the rim, finish crazy highlight lobs, act as
 a weakside rim protector, and just overall wreak havoc in transition.
 He should be a top 5 transition threat upon entering
 the league, even on defense with his timing and instincts to break up plays with blocks and steals.
 He is smooth and light
 on his feet in the open court and keeps his head up, always looking to push the ball. He has a really nice handle for a guy
  with his size, keeping the ball low to the ground out of the reach of opponents.
  This allows him to be an elite grab & go
  threat, especially with his great rebounding ability", category: "Person", people_id: 491)

Post.create!(user_id: User.all.sample.id, title: "Women should be allowed to play", user_generated: true, likes: 40,
  content: "The WNBA should be disbanded and women should be able to play in the NBA. I think that it wouldn't be received well
  at first, but attitudes will change when people see how good women can be.", team_id: 4)

Post.create!(user_id: User.all.sample.id, title: "CLE to LA", user_generated: true, likes: 80000,
  content: "Comparing CLE to LA when they got Dwight is insane imo. Lebron literally turns any team in the East into a playoff team overnight and they also have KLove (the best or second best PF in the league depending on who you talk to), Kyrie (a number 1 pick who has lived up to expectations) and a bunch of good role players). LA was a bunch of old guys and an injured Dwight who had maybe the worst season of his career.",
  team_id: 6, people_id: 241)

puts "creating 5 comments"

Comment.create!(user_id: 1,
 text: "he’s not nearly as good as charles. He’s really talented. But, listen, I love the kid,
 I wish him nothing but the best but it’s disrespectful",
 likes: 10,
 commentable_id: 1,
 created_at: DateTime.parse("Tue, 10 Dec 2019 15:16:07 UTC +00:00"),
 updated_at: DateTime.parse("Tue, 10 Dec 2019 15:16:07 UTC +00:00"),
 commentable_type: "Post"
  )
Comment.create!( user_id: 1,
 text: "Zion will destroy barkley in his prime in a one on one game",
 likes: 3,
 commentable_id: 1,
 created_at: DateTime.parse("Tue, 10 Dec 2019 15:30:25 UTC +00:00"),
 updated_at: DateTime.parse("Tue, 10 Dec 2019 15:30:25 UTC +00:00"),
 commentable_type: "Comment"
  )
  Comment.create!( user_id: 1,
 text: "Huge mistake by Atlanta for trading him.",
 likes: 32,
 commentable_id: 3,

 created_at: DateTime.parse("Tue, 10 Dec 2019 15:56:45 UTC +00:00"),
 updated_at: DateTime.parse("Tue, 10 Dec 2019 15:56:45 UTC +00:00"),
 commentable_type: "Post"
  )
  Comment.create!( user_id: 1,
 text: "I can say he passed Kobe on the Goat chase but not Jordan",
 likes: 48,
 commentable_id: 1,
 created_at: DateTime.parse("Tue, 10 Dec 2019 16:05:06 UTC +00:00"),
 updated_at: DateTime.parse("Tue, 10 Dec 2019 16:05:06 UTC +00:00"),
 commentable_type: "Post"
 )
  Comment.create!( user_id: 1,
   text: "Jordan was an amazing player. He couldn't be any closer to the greatest ever.

     He's not overrated. Others are just underrated. Jordan is overated in

     my opinion Kareemis the goat, along with his great individual accomplishments,
     was a winner. He took the Bucks, a 27 win team, and made them into NBA champions in two years.",
   likes: 50,
   commentable_id: 2,

   created_at: DateTime.parse("Tue, 10 Dec 2019 16:24:38 UTC +00:00"),
   updated_at: DateTime.parse("Tue, 10 Dec 2019 16:24:38 UTC +00:00"),
   commentable_type: "Post"

   )
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
    box.date_time = string_to_date(date_string)
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
# get_days_scores_api(date_to_string(Date.yesterday))

puts "done"









