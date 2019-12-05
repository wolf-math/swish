class YoutubeApi < ApplicationRecord
  YOUTUBE_BASE = "https://www.googleapis.com/youtube/v3/search/?key=#{ENV['YOUTUBE_API']}&part=snippet"
  CHANNELS = ['UCT83YP07yVuaH9J19YABhlw', 'UC-XWpctw55Q6b_AHo8rkJgw', 'UCEjOSbbaOfgnfRODEEMYlCw', 'UCp3dgMf1OUP2XqOpyOY2bzQ']
  MAX_RESULTS = "&maxResults=1"
  def self.all_videos(preferences)
    results = []
     preferences.each do |preference|
      CHANNELS.each do |channel|
        channel_results = HTTParty.get(YOUTUBE_BASE + "&query=#{preference}" + "&channelId=#{channel}" + MAX_RESULTS)
          channel_videos = []
          binding.pry
          channel_results['items'].each do |res|
            if res['snippet']['title'].match?(/#{preference}/i) || res['snippet']['description'].match?(/#{preference}/i)
              video = {}
              video[:id] = res['id']['videoId']
              video[:title] = res['snippet']['title']

              video[:description] = res['snippet']['description']
              video[:thumbnail] = res['snippet']['thumbnails']['medium']['url']
              channel_videos << video
            end
          end
          results << channel_videos
        end
     end
    results
    end


end


# key siel - AIzaSyBAynJxXy0JHJpZtXVJpktLAcXalMpWmcY   - aron - AIzaSyAzKX-jwQOoFX1FKsWSM9O3z1QJR1lVDtM

# https://www.googleapis.com/youtube/v3/search/?key=AIzaSyBAynJxXy0JHJpZtXVJpktLAcXalMpWmcY&part=snippet&channelId=UCT83YP07yVuaH9J19YABhlw&maxResults=4&query=iverson


# https://www.googleapis.com/youtube/v3/videos/?key=AIzaSyBAynJxXy0JHJpZtXVJpktLAcXalMpWmcY&part=snippet&id=JE23ajVX930

# https://www.googleapis.com/youtube/v3/search/?key=AIzaSyBAynJxXy0JHJpZtXVJpktLAcXalMpWmcY&part=snippet&channelId=UCT83YP07yVuaH9J19YABhlw

# https://www.googleapis.com/youtube/v3/search/?key=AIzaSyBAynJxXy0JHJpZtXVJpktLAcXalMpWmcY&part=snippet&channelId=UCT83YP07yVuaH9J19YABhlw&maxResults=30

