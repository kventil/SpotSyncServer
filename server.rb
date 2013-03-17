require 'sinatra'
require 'net/http'
require './song.rb'


current_song = Song.new

get '/*/get' do 
	current_song.to_json
end


get '/*/set/:uri' do
	spotify_uri = params[:uri]
	uri = URI("http://ws.spotify.com/lookup/1/.json?uri=#{spotify_uri}")

	song = JSON.parse(Net::HTTP.get(uri))
	out = "#{song["track"]["name"]} by "
	song["track"]["artists"].each do |artist|
		out = "#{out} #{artist["name"]}"
	end


  	current_song = Song.new(spotify_uri)
  	"New song is set to: #{out}"
end