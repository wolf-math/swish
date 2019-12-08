class TwitterApi < ApplicationRecord

  def self.perform(preferences)
    res = preferences.map do |preference|
      format_tweets(all_tweets(preference))
    end
    return res
  end

  private

  def self.format_tweets(tweets)
    results = []
      tweets['statuses'].each do |tweet|
        break if results.length >= 1
        next if tweet['user']['followers_count'].to_i < 1000

        result = {}
        result[:text] = tweet['text']
        result[:name] = tweet['user']['name']
        result[:handle] = tweet['user']['screen_name']
        result[:followers] = tweet['user']['followers_count']
        result[:avatar] = tweet['user']['profile_image_url_https']
        result[:created_at] = tweet['created_at']
        result[:url] = tweet['entities']['urls'][0]['expanded_url'] rescue nil
        result[:image] = tweet['entities']['media'][0]['media_url_https'] rescue nil

        results << result
      end

      return results
  end

  def self.all_tweets(person)
    HTTParty.get("https://api.twitter.com/1.1/search/tweets.json?q=#{person}",
        headers: { Authorization: "Bearer #{ENV['T_BEARER']}" })
  end
end



 # results['statuses'][0]['text'] TWEET TEXT
 # results['statuses'][1]['entities']['urls'][0]['url'] URL
# results['statuses'][0]['entities']['media'][0]['media_url_https'] IMAGE
#  results['statuses'][0]['user']['name']   NAME
# results['statuses'][0]['user']['screen_name']  TWITTER HANDLE
#  results['statuses'][0]['user']['followers_count'] FOLLOWER COUNT FOR FILTERING
#  results['statuses'][0]['created_at']  # created_at





# TWITER KEYS
# BbB0O6uWg2JPX9c7uxFnJ8YMK (API key)

# WGiyK4syghoo8qM0tfVhNJ92QPSwfU3mXmoB5do2sDRktuqKR2 (API secret key)


# 1201512015136804865-TFm7k46YH94QYtmfmA2jEVG8PR3aDe (Access token)

# pRdhyppU1yiI0SekDsoqhzDRrdt3Wi2HiFUG5ltV4AZwA (Access token secret)

# --header 'authorization: Bearer AAAAAAAAAAAAAAAAAAAAAFBNBAEAAAAAnlJvNH1MXl90bjiJqSnS6y0td7w%3DVJuagf8040vgDkqazlCXZzkPYwPI9WtqxJ2iWmnZ2iCsFLYVoH'



# AUTHORIZATION FOR RECEIVING BEARER TOKEN
# curl -u 'BbB0O6uWg2JPX9c7uxFnJ8YMK:WGiyK4syghoo8qM0tfVhNJ92QPSwfU3mXmoB5do2sDRktuqKR2'   --data 'grant_type=client_credentials' 'https://api.twitter.com/oauth2/token'


# MAKING AN ACTUAL REQUEST WITH BEARER TOKEN
# curl https://api.twitter.com/1.1/search/tweets.json\?q=soccer --header 'authorization: Bearer AAAAAAAAAAAAAAAAAAAAAFBNBAEAAAAAnlJvNH1MXl90bjiJqSnS6y0td7w%3DVJuagf8040vgDkqazlCXZzkPYwPI9WtqxJ2iWmnZ2iCsFLYVoH'

