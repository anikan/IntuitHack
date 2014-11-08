require "rubygems"
require "twitter"

    # returns a list of tweets containing the phrase within the dates specified
    # returns either @max_tweets tweets or all tweets found
    # @param phrase - a phrase to search for
    # @param from_date - begining date of the search ex."2011-02-28"
    # @param until_date - ending date of the search ex. "2011-03-01"
client = Twitter::REST::Client.new do |config|
  config.consumer_key    = "DYhlRhiYhJGm8OBEsBzJs9k1t"
  config.consumer_secret = "YRnVzYCj2UOY0QgP39vnrVKRapCOQF62KXVcQWIXaGJryW0eCQ"
end
    def get_tweets(phrase, from_date, until_date)

      search = Twitter::Search.new.containing(phrase) #.since_date(from_date).until_date(until_date)
      #print search
      #get all the tweets
      tweets = search.fetch
      next_tweets = search.fetch_next_page
      while(tweets.size < @max_tweets && next_tweets != nil) 
        tweets = tweets + next_tweets
        next_tweets = search.fetch_next_page
      end
      return tweets.first(@max_tweets)
    end

def client.get_all_tweets(user)
  collect_with_max_id do |max_id|
    options = {count: 200, include_rts: true}
    options[:max_id] = max_id unless max_id.nil?
    user_timeline(user, options)
   
  end
end
i=0
client.search("to:windows :(", result_type: "recent").take(300).each do |tweet|
  i+=1
  puts tweet.text
end
print i

#print client.get_all_tweets("khoi148")
#print get_tweets("nick")
#print search()
