require 'sinatra'

#small mockup for the backend

current_song = "empty"

get '/*/get' do 
	"Current_Song: #{current_song}"
end


get '/*/set/:name' do
  current_song = params[:name]
  "Current_Song: #{current_song}"
end