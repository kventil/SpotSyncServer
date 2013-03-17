require 'sinatra'

current_song = "empty"

get '/' do 
	current_song
end


get '/set/:name' do
  current_song = params[:name]
end