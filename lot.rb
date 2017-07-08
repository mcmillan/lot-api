require 'sinatra'
require 'httparty'
require_relative 'lib/now_playing'
require_relative 'lib/mixcloud'

get '/api/now_playing' do
  content_type :json
  { data: NowPlaying.fetch }.to_json
end

get '/api/shows' do
  content_type :json
  @mixcloud = Mixcloud.new
  { data: @mixcloud.shows }.to_json
end
