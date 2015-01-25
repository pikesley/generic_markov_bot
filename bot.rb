#!/usr/bin/env ruby

require 'marky_markov'
require 'dotenv'
require 'twitter'

Dotenv.load

config = {
  consumer_key:        ENV['TWITTER_CONSUMER_KEY'],
  consumer_secret:     ENV['TWITTER_CONSUMER_SECRET'],
  access_token:        ENV['TWITTER_OAUTH_TOKEN'],
  access_token_secret: ENV['TWITTER_OAUTH_SECRET']
}
client = Twitter::REST::Client.new(config)

markov = MarkyMarkov::Dictionary.new('dictionary')
Dir.entries('sources').select { |e| e[0] != '.' }.each do |text|
  markov.parse_file 'sources/%s' % text
end
content = markov.generate_1_sentences
markov.save_dictionary!

tweet = ''
content.split.each do |word|
  new_tweet = tweet << "#{word} "
  if new_tweet.length > 139
    break
  else
    tweet = new_tweet
  end
end

puts tweet
client.update tweet
