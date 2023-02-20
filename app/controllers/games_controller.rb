require 'uri'
require 'net/http'

class GamesController < ApplicationController
  def new
    @letters = Array('A'..'Z').sample(10)
  end

  def score
    answer = params[:answer].upcase.chars
    @letters = params[:letters]
    included = answer.all? do |letter|
        @letters.include?(letter)
      end

      if included
        response = URI.open("https://wagon-dictionary.herokuapp.com/#{answer.join}")
        json = JSON.parse(response.read)
            if json['found'] == true
              @result = "Congratulations! #{answer.join} is a valid English word!"
            else
              @result = "Sorry, #{answer.join} is not a valid English word.. "
            end
      else
        @result = "Sorry, #{answer.join} cannot be made out of #{@letters}.."
      end
  end
end
