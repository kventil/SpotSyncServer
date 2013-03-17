require 'sinatra'
require './song.rb'


current_song = Song.new

get '/*/get' do 
	current_song.to_json
end


get '/*/set/:name' do
  current_song = Song.new(params[:name])
end