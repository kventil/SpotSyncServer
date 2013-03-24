require 'sinatra'
require 'net/http'
require 'redis'

require './song.rb'

set :environment, :production

#todo http://localhost:8808/doc_root/sinatra-1.4.1/Sinatra/Helpers.html
#status + meldungen korrekt implementieren
#redis://redistogo:3193dc6b3ab4d856efbbf83fe7e12061@tarpon.redistogo.com:9083/


uri = URI.parse(ENV["REDISTOGO_URL"])
$db = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

def set_song(params)
  $db.set(params[0],params[1])
end


def get_song(params)
  $db.get(params[0])
end

get '/*/get' do
  get_song(params[:splat])
end

#direct uri-call - returns 200 on sucess and 403 on error
get '/*/set/*' do
  set_song(params[:splat])
end


#servercall
get '/' do
  # return static startpage
  File.read(File.join('public', 'index.html'))
end
