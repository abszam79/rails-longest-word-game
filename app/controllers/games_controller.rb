require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ("A".."Z").to_a.sample }
  end

  # def score
  #   @word = params[:word]
  #   @letters = params[:letters].split(" ")
  #   if included?(@word, @letters)
  #     if english_word?(@word)
  #       @score = @word.length
  #       @message = "well done"
  #     else
  #       @score = 0
  #       @message = "not an english word"
  #     end
  #   else
  #     @score = 0
  #     @message = "not in the grid"
  #   end
  # end

 def score
    @word = params[:word]
    @letters = params[:letters].split("")

    if english_word?(@word) == true && (@letters & @word.upcase.split("")).size == @word.size
      @result = "'#{@word}' is valid according to the grid and is an English word"
      @your_score = @word.size
    elsif
      english_word?(@word) == true && (@letters & @word.upcase.split("")).size != @word.size
      @result = "'#{@word}' is not in the grid"
      @your_score = 0
    else
      @result = "'#{@word}' is not english"
      @your_score = 0
    end
  end



  # def included?(word, letters)
  #   # word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  #   word.upcase.split("").each do |letter|
  #     return false if word.count(letter) > letters.count(letter)
  #   end
  #   return true
  # end

  # def run_game(word, letters)
  #   @result = score(word, letters)
  # end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

end



# @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }
# if @word.length <= @letters.count(letter)
#       @result = "c taupe!"
#     else
#       @result = "ca mache po!"
#     end
