
require 'rubygems'
require 'sinatra'
require 'twitter'
require 'json'

require "sinatra/config_file"

config_file 'keys.yml'

enable :sessions
configure do
  set :public_folder, Proc.new { File.join(root, "static") }
end

helpers do
  def current_user
    @current_user ||= User.get(session[:user_id]) if session[:user_id]
  end
end

before do
  Twitter.configure do |config|
    config.consumer_key = settings.twitter["consumer_key"]
    config.consumer_secret = settings.twitter["consumer_secret"]
    config.oauth_token = settings.twitter["oauth_token"]
    config.oauth_token_secret = settings.twitter["oauth_token_secret"]
  end
end


get '/' do
  erb :root
end

get '/search' do
  erb :root
end


get '/top_trends' do
  trends = Twitter.trends
  trends_res = []
  i = -1
  trends.each do |trend|
    i = i + 1
    trends_res[i] = {name: trend.name, url: trend.url}
  end
  content_type :json
  trends_res.to_json
end

get '/trends/:search_term' do

end


