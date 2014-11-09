require "rubygems"
require "twitter"
require './alchemyapi_ruby/alchemyapi'
require 'json'
require "net/http"
require "uri"

begin
input = [(print 'Please enter a stock ticker symbol (Try AAPL, INTC, MSFT): '), gets.rstrip][1]
										stockAddress = URI.parse("http://dev.markitondemand.com/Api/v2/Quote/json?symbol=" + input)
																		      response = Net::HTTP.get_response(stockAddress)

# Full
	http = Net::HTTP.new(stockAddress.host, stockAddress.port)
response = http.request(Net::HTTP::Get.new(stockAddress.request_uri))

	rescue
	puts 'Error. Please enter a real stock ticker.'
	end


text = JSON.parse(response.body)
	change = text['Change']
	name = text['Name']
#puts change


alchemyapi = AlchemyAPI.new()
	client = Twitter::REST::Client.new do |config|
	config.consumer_key    = "DYhlRhiYhJGm8OBEsBzJs9k1t"
	config.consumer_secret = "YRnVzYCj2UOY0QgP39vnrVKRapCOQF62KXVcQWIXaGJryW0eCQ"
	end



	index=0
	listofthings = []

	client.search(name, result_type: "recent").take(10).each do |tweet|
	listofthings[index] = tweet.text
	index+=1

	end
#	print "Number of results: "
#	puts index
	puts 'You chose ' + name
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
finalSent = (posSentiment.to_f/posSentimentNum.to_f) > (negSentiment.to_f/negSentimentNum.to_f)
	if finalSent == true
#	puts 'predominantly positive! (' + ((posSentiment.to_f/posSentimentNum.to_f).to_f * 100.0).to_s + ' %)'
	if change.round(2) > 0.0 
	puts 'This stock does correlate with its twitter data. According to our results, '  +  ((posSentiment.to_f/posSentimentNum.to_f) * 100.0).to_i.to_s + '% of people on twitter have positive feelings about ' + name + ' and, ' + name + "'s stock has increased by a value of $" + change.round(2).to_s + ' in the past few days.'
	else
	puts 'This stock does not correlate with its twitter data.  According to our results, '  +  ((posSentiment.to_f/posSentimentNum.to_f) * 100.0).to_i.to_s + '% of people on twitter have positive feelings about ' + name + '. However, ' + name + "'s stock has decreased by a value of $" + change.round(2).abs.to_s + ' in the past few days.'
	end
	else
#	puts 'predominantly negative! (' + ((negSentiment.to_f/negSentimentNum.to_f).to_f * 100.0).to_s + ' %)'
	if change.round(2) > 0.0
	puts 'This stock does correlate with its twitter data. According to our results, '  +  ((negSentiment.to_f/negSentimentNum.to_f) * 100.0).to_i.abs.to_s + '% of people on twitter have negative feelings about ' + name + ' and, ' + name + "'s stock has decreased by a value of $" + change.round(2).abs.to_s + ' in the past few days.'
	else 
	puts 'This stock does not correlate with its twitter data.  According to our results, '  +  ((negSentiment.to_f/negSentimentNum.to_f) * 100.0).to_i.abs.to_s  + '% of people on twitter have negative feelings about ' + name + '. However, ' + name + "'s stock has increased by a value of $" + change.round(2).abs.to_s + ' in the past few days.'

	end
	end

