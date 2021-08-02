require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (1..10).map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    @word = params[:word]
    @grid = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    serialized_dictionary = URI.open(url).read
    dictionary = JSON.parse(serialized_dictionary)
    if dictionary["found"] && @word.chars.all? { |char| @word.chars.count(char) <= @grid.count(char.upcase) }
      return @feedback = "The word is valid according to the grid and is an English word"
    elsif !dictionary["found"] && @word.chars.all? { |char| @word.chars.count(char) <= @grid.count(char.upcase) }
      return @feedback = "The word is valid according to the grid, but is not a valid English word"
    else
      return @feedback = "The word can’t be built out of the original grid"
    end
  end
end
