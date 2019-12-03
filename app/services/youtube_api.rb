class YoutubeApi
<<<<<<< HEAD
  YOUTUBE_BASE = "https://www.googleapis.com/youtube/v3/search/?key=#{ENV['YOUTUBE_API']}&part=snippet"
=======
  BASE = "https://www.googleapis.com/youtube/v3/search/?key=#{ENV['YOUTUBE_API']}&part=snippet"
>>>>>>> d4be5e26f81ae56a409e6139a9e600ae80f623be
  CHANNELS = ['UCT83YP07yVuaH9J19YABhlw', 'UC-XWpctw55Q6b_AHo8rkJgw', 'UCEjOSbbaOfgnfRODEEMYlCw', 'UCp3dgMf1OUP2XqOpyOY2bzQ']
  MAX_RESULTS = "&maxResults=10"

  def self.all_videos
    CHANNELS.each do |channel|
<<<<<<< HEAD
      channel_results = HTTParty.get(YOUTUBE_BASE + "&channelId=#{channel}" + MAX_RESULTS + "&query=bryant")
=======
      channel_results = HTTParty.get(BASE + "&channelId=#{channel}" + MAX_RESULTS + "&query=bryant")
>>>>>>> d4be5e26f81ae56a409e6139a9e600ae80f623be
       p  channel_results['items'].count
        channel_results['items'].each do |res|
          id = res['id']['videoId']
          title = res['snippet']['title']
          description = res['snippet']['description']
          thumbnail = res['snippet']['thumbnails']['medium']['url']

          p [id, title, description, thumbnail]
          puts "\n"
        end
    end
  end
end

<<<<<<< HEAD
class TwitterApi
  TWITTER_BASE = "https://api.twitter.com/1.1/search/tweets.json\?q=bryant#{TWITTER_HEADER}"
  # PLAYERS + TEAMS

  def trending_tweets

    HTTParty.get("https://api.twitter.com/1.1/search/tweets.json",
        headers: 'authorization: Bearer AAAAAAAAAAAAAAAAAAAAAFBNBAEAAAAAnlJvNH1MXl90bjiJqSnS6y0td7w=VJuagf8040vgDkqazlCXZzkPYwPI9WtqxJ2iWmnZ2iCsFLYVoH'
      )
  end
end




=======
>>>>>>> d4be5e26f81ae56a409e6139a9e600ae80f623be
# https://www.googleapis.com/youtube/v3/search/?key=AIzaSyBAynJxXy0JHJpZtXVJpktLAcXalMpWmcY&part=snippet&channelId=UCT83YP07yVuaH9J19YABhlw


# https://www.googleapis.com/youtube/v3/videos/?key=AIzaSyBAynJxXy0JHJpZtXVJpktLAcXalMpWmcY&part=snippet&id=JE23ajVX930

# https://www.googleapis.com/youtube/v3/search/?key=AIzaSyBAynJxXy0JHJpZtXVJpktLAcXalMpWmcY&part=snippet&channelId=UCT83YP07yVuaH9J19YABhlw

# https://www.googleapis.com/youtube/v3/search/?key=AIzaSyBAynJxXy0JHJpZtXVJpktLAcXalMpWmcY&part=snippet&channelId=UCT83YP07yVuaH9J19YABhlw&maxResults=30



# TWITER KEYS
# BbB0O6uWg2JPX9c7uxFnJ8YMK (API key)

# WGiyK4syghoo8qM0tfVhNJ92QPSwfU3mXmoB5do2sDRktuqKR2 (API secret key)
<<<<<<< HEAD


# 1201512015136804865-TFm7k46YH94QYtmfmA2jEVG8PR3aDe (Access token)

# pRdhyppU1yiI0SekDsoqhzDRrdt3Wi2HiFUG5ltV4AZwA (Access token secret)

# --header 'authorization: Bearer AAAAAAAAAAAAAAAAAAAAAFBNBAEAAAAAnlJvNH1MXl90bjiJqSnS6y0td7w%3DVJuagf8040vgDkqazlCXZzkPYwPI9WtqxJ2iWmnZ2iCsFLYVoH'



# AUTHORIZATION FOR RECEIVING BEARER TOKEN
# curl -u 'BbB0O6uWg2JPX9c7uxFnJ8YMK:WGiyK4syghoo8qM0tfVhNJ92QPSwfU3mXmoB5do2sDRktuqKR2'   --data 'grant_type=client_credentials' 'https://api.twitter.com/oauth2/token'


# MAKING AN ACTUAL REQUEST WITH BEARER TOKEN
# curl https://api.twitter.com/1.1/search/tweets.json\?q=soccer --header 'authorization: Bearer AAAAAAAAAAAAAAAAAAAAAFBNBAEAAAAAnlJvNH1MXl90bjiJqSnS6y0td7w%3DVJuagf8040vgDkqazlCXZzkPYwPI9WtqxJ2iWmnZ2iCsFLYVoH'
#
=======
>>>>>>> d4be5e26f81ae56a409e6139a9e600ae80f623be
