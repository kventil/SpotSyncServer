require 'sinatra'
require 'net/http'
require './song.rb'


$current_song = Song.new


def setSong(spotify_uri)
	if spotify_uri.include? "http"
		spotify_uri['http://open.spotify.com/track/'] = "spotify:track:"
	end

	uri = URI("http://ws.spotify.com/lookup/1/.json?uri=#{spotify_uri}")
	out = 403
	
	#fetch song-details 
	response = Net::HTTP.get(uri)
	unless response == ""
		song_info = JSON.parse(response)
		$current_song = Song.new(spotify_uri,song_info)
  		out = 200
  	end
  	out
 end


get '/*/get' do
	$current_song.to_json
end

#direct uri-call - returns 200 on sucess and 403 on error
get '/*/set/:uri' do
	setSong(params[:uri])
end


#interface-call
get '/' do
# return static startpage
  File.read(File.join('public', 'index.html'))
end

#Wrapper fuers webinterface
post '/form/set' do
	out = "Not a valid Song. Sorry :-("
	unless setSong(params[:uri]) == 403
		out = "Partying now to: #{$current_song.to_s}"
	end
	out
end

#returns the current playing song
#nothing if the time betweet set is > than set+songlength
get '*/current_song' do
	now = Time.now.to_i
	if $current_song.set + $current_song.length > now
		"#{$current_song.to_s} - #{now - $current_song.set} / #{$current_song.length}"
	else
		"empty"
	end
end

get '*/remaining' do
 now = Time.now.to_i
 remaining  = ($current_song.set + $current_song.length) - now
 unless 0 > remaining 
 	"#{remaining.to_i}"
 else
 	"0"
 end
end
