require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    letters_array = ('a'..'z').to_a
    @letters = letters_array.sample(10)
  end

  def score
    @letters = params[:letter]
    @word = params[:word]
    @included = included_in_grid(@letters, @word)
    @english = english?(@word)
  end

  def included_in_grid(letters, word)
    word.chars.all?(|letter| word.count(letter) <= letters.count(letter))
  end

  def english?(word)
    url = "https://wagon-dictionary.herokuapp.com/pear"
    word_serialised = URI.open(url).read
    words = JSON.parse(word_serialised)
    words["found"]
  end

end
