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

address = URI("https://api.twitter.com/1.1/search/tweets.json?q=Microsoft%20%3A%29")

puts address

request = Net::HTTP::Get.new address.request_uri

# Print data about a list of Tweets
def print_timeline(tweets)
  # ADD CODE TO ITERATE THROUGH EACH TWEET AND PRINT ITS TEXT
    print "I got here"
end

# Set up HTTP.
http             = Net::HTTP.new address.host, address.port
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

# Parse and print the Tweet if the response code was 200
tweets = nil
if response.code == '200' then
  tweets = JSON.parse(response.body)
  print_timeline(tweets)
end
nil
