#!/usr/bin/env ruby

require 'yaml'

twurlrc = YAML.load File.read "#{ENV['HOME']}/.twurlrc"

creds = twurlrc['profiles'][ARGV[0]]

creds = creds[creds.keys[0]]

out = {}
out['TWITTER_CONSUMER_KEY'] = creds['consumer_key']
out['TWITTER_CONSUMER_SECRET'] = creds['consumer_secret']
out['TWITTER_OAUTH_TOKEN'] = creds['token']
out['TWITTER_OAUTH_SECRET'] = creds['secret']

print 'Writing ./.env... '
env = File.open '.env', 'w'
out.each do |k, v|
  env.write "#{k}: #{v}"
  env.write "\n"
end
env.close
puts 'done'
