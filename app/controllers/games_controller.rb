require 'json'
require 'open-uri'
class GamesController < ApplicationController
  def new
    @random_grid = []
    @grid_size = (rand * 20).round
    @alphabet = ('A'..'Z').to_a
    @grid_size.times { @random_grid.push(@alphabet.sample) }
  end

  def score
    @user_answer = params['answer'].upcase
    if english?(@user_answer) == false
      @message = "Sorry but #{@user_answer} does not seem to be a valid english word"
    elsif grid_matching?(@user_answer, @random_grid) == false
      @mesage = "Sorry but #{@user_answer} can\'t be built out of #{@random_grid}"

    else
      @message = "Congratulations #{@user_answer} is a valid English word"
    end
  end

  private

  def english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    # user['found'] return true or false
    user['found']
  end

  def grid_matching?(word, grid)
    # Should return true or false
    sorted_word = word.split(//).sort
    sorted_grid = grid.sort
    word_size = sorted_word.length - 1
    return true if sorted_grid[0..word_size] == sorted_word
  end
end
