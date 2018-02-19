require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    random_grid = ("a".."z").to_a
    counter = 0
      until counter == 10
        @letters << random_grid.sample
        counter += 1
      end
    return @letters
  end

  def checks(input)
    url = "https://wagon-dictionary.herokuapp.com/#{@input}"
    list_of_words = JSON.parse(open(url).read)
    if !list_of_words["found"]
      answer = "not an english word, your score is 0"
    elsif !included(@grid, @input)
      answer = "not in the grid word, your score is 0"
    else
      answer = "Well done, your score is #{@results}!"
    end
  end

    def the_result(input)
    url = "https://wagon-dictionary.herokuapp.com/#{@input}"
    list_of_words = JSON.parse(open(url).read)
    if !list_of_words["found"]
      result = 0
    elsif !included(@grid, @input)
      result = 0
    else
      result = @input.length.to_i
    end
  end

  def score
    raise
    @input = params[:word]
    @grid = params[:grid]
    @answer = checks(@input)
    @results = the_result(@input)
  end

  def included(grid, attempt)
  attempt.chars.all? { |letter| grid.count(letter) >= attempt.count(letter) }
  end
end

