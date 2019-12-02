class YoutubeApi
  BASE = "https://www.googleapis.com/youtube/v3/search/?key=#{ENV['YOUTUBE_API']}&part=snippet"
  CHANNELS = ['UCT83YP07yVuaH9J19YABhlw', 'UC-XWpctw55Q6b_AHo8rkJgw', 'UCEjOSbbaOfgnfRODEEMYlCw', 'UCp3dgMf1OUP2XqOpyOY2bzQ']
  MAX_RESULTS = "&maxResults=10"

  def self.all_videos
    CHANNELS.each do |channel|
      channel_results = HTTParty.get(BASE + "&channelId=#{channel}" + MAX_RESULTS + "&query=bryant")
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

# https://www.googleapis.com/youtube/v3/search/?key=AIzaSyBAynJxXy0JHJpZtXVJpktLAcXalMpWmcY&part=snippet&channelId=UCT83YP07yVuaH9J19YABhlw


# https://www.googleapis.com/youtube/v3/videos/?key=AIzaSyBAynJxXy0JHJpZtXVJpktLAcXalMpWmcY&part=snippet&id=JE23ajVX930

# https://www.googleapis.com/youtube/v3/search/?key=AIzaSyBAynJxXy0JHJpZtXVJpktLAcXalMpWmcY&part=snippet&channelId=UCT83YP07yVuaH9J19YABhlw

# https://www.googleapis.com/youtube/v3/search/?key=AIzaSyBAynJxXy0JHJpZtXVJpktLAcXalMpWmcY&part=snippet&channelId=UCT83YP07yVuaH9J19YABhlw&maxResults=30



# TWITER KEYS
# BbB0O6uWg2JPX9c7uxFnJ8YMK (API key)

# WGiyK4syghoo8qM0tfVhNJ92QPSwfU3mXmoB5do2sDRktuqKR2 (API secret key)
