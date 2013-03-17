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
	out = "Not a valid song-uri :("

	#fetch song-details 
	response = Net::HTTP.get(uri)
	unless response == ""
		song = JSON.parse(response)
		out = "#{song["track"]["name"]} by "
		song["track"]["artists"].each do |artist|
			out = "#{out} #{artist["name"]}"
		end
		current_song = Song.new(spotify_uri)
  		out = "New song is set to: #{out} :-)"
  	end
  	out
end