require "rubygems"
require "twitter"
require './alchemyapi_ruby/alchemyapi'
require 'json'
require "net/http"
require "uri"

rtKey = 'q9fg2bgt3592jk6gd3h3eyyp'
begin
input = [(print 'Please enter a Movie Title: '), gets.rstrip][1]
input.sub! ' ', '%20'

										stockAddress = URI.parse("http://api.rottentomatoes.com/api/public/v1.0/movies.json?apiKey=q9fg2bgt3592jk6gd3h3eyyp&q=" + input)
																		      response = Net::HTTP.get_response(stockAddress)

# Full
	http = Net::HTTP.new(stockAddress.host, stockAddress.port)
response = http.request(Net::HTTP::Get.new(stockAddress.request_uri))

	rescue
	
	end


text = JSON.parse(response.body)
	audScore = (text['movies'][0])#['ratings'][0]['audience_score'][0]).to_i
audScore1 = audScore['ratings']
audScore2 = audScore1['audience_score']
#puts audScore2
	name1 = (text['movies'][0])
name = name1['title']
puts 'The movie you selected was ' + name

alchemyapi = AlchemyAPI.new()
	client = Twitter::REST::Client.new do |config|
	config.consumer_key    = "HWMrpPEAKPxX5fTI3rKM3ISfw"
	config.consumer_secret = "Iho84gxC5haHnueIQk2zbkJ1WJYsZDMzAE6FjB26yaI1m6klDm"
	end



	index=0
	listofthings = []

	client.search(input, result_type: "recent").take(10).each do |tweet|
	listofthings[index] = tweet.text
	index+=1

	end
	posSentimentNum = 0.0
	posSentiment = 0.0
	negSentimentNum = 0.0
	negSentiment = 0.0
	listofthings.length.times do |x|
	response = alchemyapi.sentiment('text', listofthings[x])
	if response['status'] == 'OK'
	if response['docSentiment'].key?('score')
#puts 'score: ' + response['docSentiment']['score'] + ', type: ' + response['docSentiment']['type'] 
	if response['docSentiment']['score'].to_f > 0.0
	posSentimentNum+=1.0
	posSentiment += response['docSentiment']['score'].to_f
	else
	negSentimentNum+=1.0
	negSentiment += response['docSentiment']['score'].to_f 
	end

	end
	else
#	puts 'Error in sentiment analysis call: ' + response['statusInfo']
	end
	end
##puts posSentiment
#puts negSentiment
if (posSentiment == 0.0 || negSentiment == 0.0)
puts 'Error'
else
	finalSent = 0.0
finalSent = (posSentiment.to_f/posSentimentNum.to_f) > (negSentiment.to_f/negSentimentNum.to_f).abs
	if finalSent == true
#	puts 'predominantly positive! (' + ((posSentiment.to_f/posSentimentNum.to_f).to_f * 100.0).to_s + ' %)'
	if audScore2 > 50 
	puts 'According to Twitter, '  +  ((posSentiment.to_f/posSentimentNum.to_f) * 100.0).to_i.to_s + '% of people have positive feelings about ' + name + ', and ' + name + ' has a rating of ' + audScore2.to_s + ' on RottenTomatoes. In this case, Twitter is accurate.' 
	else
	puts ' According to Twitter, '  +  ((posSentiment.to_f/posSentimentNum.to_f) * 100.0).to_i.to_s + '% of people have positive feelings about ' + name + ', and ' + name + " has a rating of " + audScore2.to_s + ' on RottenTomatoes. In this case, Twitter is not accurate. '
	end
	else
if audScore2 <= 50
#	puts 'predominantly negative! (' + ((negSentiment.to_f/negSentimentNum.to_f).to_f * 100.0).to_s + ' %)'
	puts 'According to Twitter, '  +  ((negSentiment.to_f/negSentimentNum.to_f) * 100.0).to_i.abs().to_s + '% of people have negative feelings about ' + name + ', and ' + name + " has a rating of " + audScore2.to_s + ' on RottenTomatoes. In this case, Twitter is accurate. '
	else 
	puts 'According to Twitter, '  +  ((negSentiment.to_f/negSentimentNum.to_f) * 100.0).abs().to_i.to_s  + '% of people have negative feelings about ' + name + ', and ' + name+ " has a rating of " + audScore2.to_s + ' on RottenTomatoes. In this case, Twitter is not accurate. '
end
	end
end
