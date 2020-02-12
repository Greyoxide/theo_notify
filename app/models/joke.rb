class Joke
  require 'open-uri'
  def initialize
    @body = open('https://icanhazdadjoke.com/', { 'Accept' => 'text/plain' }).read
  end
  attr_accessor :body
end
