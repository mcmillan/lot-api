require 'sinatra'
require 'httparty'
require_relative 'lib/now_playing'

get '/api/now_playing' do
  content_type :json
  NowPlaying.fetch.to_json
end
