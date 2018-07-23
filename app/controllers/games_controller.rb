require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
  alphabet_arr = ('A'..'Z').to_a
  @letters = []
  i=0
  while i < 10
    index=rand(10)
    @letters << alphabet_arr[index]
    i +=1
  end
end


  def score
  @input = params[:word]
  @letters = params[:letters].split(" ")
  url = "https://wagon-dictionary.herokuapp.com/#{@input}"
  json_content = open(url).read
  res = JSON.parse(json_content)

  if res['found'] == true
    @input.upcase.chars.each do |char|
      bool = @letters.include?(char)
      @letters.delete_at(@letters.index(char)) if bool
      if bool == false
        @response = "Sorry but #{@input} can't be built"
        session[:score] = 0
        break
      end
      @response = "Congrats! #{@input} is a valid English word"
      session[:score] = @input.length
    end
  else
    @response = "Sorry but #{@input} does not seem to be a valid English word"
    session[:score] = 0
  end
 end

end
