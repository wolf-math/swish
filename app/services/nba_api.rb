class NbaApi < ApplicationRecord

  def season
    # start with date.new()
    all_dates = []
    season_start = Time.new(Time.now.year, 10, 15)
    today = "#{Time.now.year}#{format('%02i', Time.now.month)}#{format('%02i', Time.now.day)}"
    total_days = (today - season_start) / 86_400
    # iterate total_days number of times backwards
    total_days.each do |date|


  end

  def nba_nab_today(today)
    today = "#{Time.now.year}#{format('%02i', Time.now.month)}#{format('%02i', Time.now.day)}"
    url = "http://data.nba.net/10s/prod/v1/#{today}/scoreboard.json"
    data = HTTParty.get(url)
    return data["games"]
  end

  def days_score
    scores = []
    games.each do |game|
      scores << { game["vTeam"]["triCode"] => game["vTeam"]["score"], game["hTeam"]["triCode"] => game["hTeam"]["score"] }
    end
  end

  # iterate through all dates to get all scores from the season
end
