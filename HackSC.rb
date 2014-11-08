require 'rubygems'
require 'oauth'
require 'json'

# Now you will fetch /1.1/statuses/user_timeline.json,
# returns a list of public Tweets from the specified
# account.
#baseurl = "https://api.twitter.com"
#path    = "/1.1/tweets.json"

#company = "Microsoft%20%3A%29"
#company2 = "Microsoft%20%3A%28"
#query   = URI.encode_www_form(company + "%20%3A")

#address = URI("#{baseurl}#{path}?#{company}")
#address2 = URI("#{baseurl}#{path}?#{company2}")

addressNeg = URI("https://api.twitter.com/1.1/search/tweets.json?q=Microsoft%20%3A%28")

addressPos = URI("https://api.twitter.com/1.1/search/tweets.json?q=Microsoft%20%3A%29")

#puts address
#puts address2

request = Net::HTTP::Get.new addressPos.request_uri

# Set up HTTP.
http             = Net::HTTP.new addressPos.host, addressPos.port
http.use_ssl     = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

# If you entered your credentials in the first
# exercise, no need to enter them again here. The
# ||= operator will only assign these values if
# they are not already set.
consumer_key = OAuth::Consumer.new(
    "HWMrpPEAKPxX5fTI3rKM3ISfw",
    "Iho84gxC5haHnueIQk2zbkJ1WJYsZDMzAE6FjB26yaI1m6klDm")
access_token = OAuth::Token.new(
    "2894024059-FfR6ambgDmHlwrGIEeAFI2f4x6uRMwn1l71qd9Q",
    "jG896HLovEndWDmZBVfuLqSgVCreFX3EWcT3Qy00Az5Pq")

# Issue the request.
request.oauth! http, consumer_key, access_token
http.start
response = http.request request

# Print data about a list of Tweets
def compareTweets(tweetPositive, tweetNegative)
  # ADD CODE TO ITERATE THROUGH EACH TWEET AND PRINT ITS TEXT
    print tweetPositive
end

# Parse and print the Tweet if the response code was 200
tweetsPos = nil
tweetsNeg = nil

if response.code == '200' then
  tweetsPos = JSON.parse(response.body)
  
  #Now request the negative components
  request = Net::HTTP::Get.new addressNeg.request_uri

  # Set up HTTP.
  http             = Net::HTTP.new addressNeg.host, addressNeg.port
  http.use_ssl     = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER

  # Issue the request.
  request.oauth! http, consumer_key, access_token
  http.start
  response = http.request request
  
  tweetsNeg = JSON.parse(response.body)
  #print tweetsNeg
  
  compareTweets(tweetsPos, tweetsNeg)
end




nil
