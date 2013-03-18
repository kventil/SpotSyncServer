require 'json'

class Song
	attr_accessor :uri
	attr_accessor :set
	attr_accessor :info
	
	def initialize(song_uri = "empty",song_info = "")
	  @uri =  song_uri
	  @info = song_info
	  @set =  Time.now.to_i
  end

  def to_json
  	JSON.generate [{:uri=>@uri,:set=>@set,:info=>@info}]
  end

  def length
  	@info["track"]["length"]
  end

  def name
  	@info["track"]["name"]
  end

  def artists 
  	@info["track"]["artists"]
  end

  def to_s
  	"#{self.name} by #{self.artists[0]["name"]}"
  end
end