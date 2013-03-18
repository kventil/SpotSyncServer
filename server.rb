require 'sinatra'
require 'net/http'
require './song.rb'


$current_song = Song.new


def setSong(spotify_uri)
	if spotify_uri.include? "http"
		spotify_uri['http://open.spotify.com/track/'] = "spotify:track:"
	end

	uri = URI("http://ws.spotify.com/lookup/1/.json?uri=#{spotify_uri}")
	out = 404 #bad country

	#fetch song-details 
	response = Net::HTTP.get(uri)
	unless response == ""
		song_info = JSON.parse(response)
		$current_song = Song.new(spotify_uri,song_info)
  		out = 200 #new song :D
  	end
  	out
 end


 def submit_form
 	'
 	<form name="input" action="/form/set" method="post">
	Gimme a new Song: <input type="text" name="uri">
	<input type="submit" value="Submit">
	</form>'
 end


get '/*/get' do 
	$current_song.to_json
end

#direct uri-call
get '/*/set/:uri' do
	spotify_uri = params[:uri]
	setSong(spotify_uri)
end


#interface-call
get '/' do
# return static startpage
  File.read(File.join('public', 'index.html'))
end

#interfacepost
post '/form/set' do
	setSong(params[:uri])
end
