require 'uri'
require 'json'
require 'net/http'

class GameController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ("A".."Z").to_a.sample
    end
    @letters
  end

  def score
    @guess = params[:guess]
    @grid = params[:grid]
      if validate_grid(@guess, @grid) == false
        @message = "The word is not in the grid"
      elsif the_word_english(@guess) == false
        @message = "The word is not an English word"
      else
        @message = "all good"
      end
      # raise
  end

  def validate_grid(word, grid)
    word = word.upcase.chars
    word.all? { |letter| grid.include?(letter) && word.count(letter) <= grid.count(letter) }
  end

  def the_word_english(word)
    url = URI("https://dictionary.lewagon.com/#{word}")
    valid = Net::HTTP.get(url)
    result = JSON.parse(valid)
    result['found']
  end

end
