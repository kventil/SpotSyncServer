require 'sinatra'

class Song
	attr_accessor :uri
	attr_accessor :set
	
	def initialize(uri = "empty")
	  @uri =  uri
	  @set =  Time.now.getutc
  end
end



current_song = Song.new

get '/*/get' do 
	"#{current_song.uri} 
	#{current_song.set}"
end


get '/*/set/:name' do
  current_song = Song.new(params[:name])
end