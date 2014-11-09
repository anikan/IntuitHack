require "rubygems"
require "twitter"
require './alchemyapi_ruby/alchemyapi'
require 'json'

# returns a list of tweets containing the phrase within the dates specified
# returns either @max_tweets tweets or all tweets found
# @param phrase - a phrase to search for
# @param from_date - begining date of the search ex."2011-02-28"
# @param until_date - ending date of the search ex. "2011-03-01"

stockAddress = URI("http://dev.markitondemand.com/Api/v2/Quote/jsonp?symbol=AAPL")
request = Net::HTTP::Get.new stockAddress.request_uri
http = Net::HTTP.new stockAddress.host, stockAddress.port
#http.use_ssl = true
#http.verify_mode = OpenSSL::SSL::VERIFY_PEER

response = http.request request
puts response['LastPrice']
puts "help"

#text = JSON.parse(response.body)
#price = text["LastPrice"]
puts price


alchemyapi = AlchemyAPI.new()
	client = Twitter::REST::Client.new do |config|
	config.consumer_key    = "DYhlRhiYhJGm8OBEsBzJs9k1t"
	config.consumer_secret = "YRnVzYCj2UOY0QgP39vnrVKRapCOQF62KXVcQWIXaGJryW0eCQ"
	end



	index=0
	listofthings = []

	client.search("murder", result_type: "recent").take(10).each do |tweet|
#puts tweet.text
	listofthings[index] = tweet.text
	index+=1

	end
	print "Number of results: "
	puts index

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


	finalSent = 0.0
finalSent = (posSentiment.to_f/posSentimentNum.to_f) > (negSentiment.to_f/posSentimentNum.to_f)
	if finalSent == true
	puts 'predominantly positive! (' + ((posSentiment.to_f/posSentimentNum.to_f).to_f * 100.0).to_s + ' %)'
	else
	puts 'predominantly negative! (' + ((negSentiment.to_f/negSentimentNum.to_f).to_f * 100.0).to_s + ' %)'
	end
