require 'sinatra'
require 'net/http'
require './song.rb'


current_song = Song.new


def setSong(spotify_uri)
	if spotify_uri.include? "http"
		spotify_uri['http://open.spotify.com/track/'] = "spotify:track:"
	end


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
		out = "#{out} (#{song["track"]["length"]})"
		current_song = Song.new(spotify_uri)
  		out = "New song is set to: #{out} :-)"
  	end
  	out
 end


 def submit_form
 	'<form name="input" action="/form/set" method="post">
Song: <input type="text" name="uri">
<input type="submit" value="Submit">
</form>'
 end


get '/*/get' do 
	current_song.to_json
end

#direct uri-call
get '/*/set/:uri' do
	spotify_uri = params[:uri]
	setSong(spotify_uri)
end


#interface-call
get '/' do
 submit_form
end

#interfacepost
post '/form/set' do
	spotify_uri = params[:uri]
	"#{setSong(spotify_uri)} <br> #{submit_form}"
end