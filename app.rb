
require 'rubygems'
require 'sinatra'
require 'twitter'
require 'json'

configure do
  set :public_folder, Proc.new { File.join(root, "static") }
end

helpers do

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


