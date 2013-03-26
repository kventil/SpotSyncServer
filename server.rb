require 'sinatra'
require 'net/http'
require 'redis'

require './song.rb'

set :environment, :production
disable :logging 

#todo http://localhost:8808/doc_root/sinatra-1.4.1/Sinatra/Helpers.html
#status + meldungen korrekt implementieren


uri = URI.parse(ENV["REDISTOGO_URL"])
$db = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

def set_song(params)
  $db.set(params[0],params[1])
end

def get_song(params)
  #value or nil if key doesn't exist
  $db.get(params[0])
end

get '/*/get' do
  body = get_song(params[:splat])
  if body.nil?
    return 404 #no token found
  end
  return [200,body] #song + url found
end

#direct uri-call - returns 200 on sucess and 403 on error
get '/*/set/*' do
  #always ok because set can't go wrong
  set_song(params[:splat])
  return 200 #everything ok
end


#servercall
get '/' do
  # return static startpage
  File.read(File.join('public', 'index.html'))
end