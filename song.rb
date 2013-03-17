require 'json'


class Song
	attr_accessor :uri
	attr_accessor :set
	
	def initialize(uri = "empty")
	  @uri =  uri
	  @set =  Time.now.to_i
  end

  def to_json
  	JSON.generate [{"uri"=>@uri,"set"=>@set}]
  end
end


