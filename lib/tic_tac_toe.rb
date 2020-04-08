require 'pry'

class TicTacToe 
  attr_accessor :board
  
  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8], 
    [0, 4, 8],
    [2, 4, 6]
    ]
  
  def initialize
    @board = Array.new(9, " ")
  end 
  
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  def input_to_index(input)
    input = input.to_i
    input = input - 1
  end 
  
  def move(input, token = "X")
    @board[input] = token
  end 
  
  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end
  
  def valid_move?(input)
   if input.between?(0, 8) && !position_taken?(input)
     true
   end
  end
  
  def turn 
    puts "Please enter a number 1-9:"
    input = gets.strip
    input = input_to_index(input)
    if valid_move?(input)
      token = current_player
      move(input, token) 
      display_board
    else
      turn
    end
  end
  
  def turn_count
    counter = 0 
    @board.each do |position|
      if position == "X" || position == "O"
        counter += 1
      end 
    end 
      counter
  end 
  
  def current_player
    turn_count.even? ? "X" : "O"
  end 

  def won?
  #iterates through nested array, combo is each array of win combinations 
  # if elements 0, 1, 2 in array match x or o the game is won
    x = WIN_COMBINATIONS.find{|combo|
      @board[combo[0]] == "X" &&
      @board[combo[1]] == "X" &&
      @board[combo[2]] == "X"
    }  
    o = WIN_COMBINATIONS.find{|combo|
      @board[combo[0]] == "O" &&
      @board[combo[1]] == "O" &&
      @board[combo[2]] == "O"
    }
    #to return winning combo return x or o
    return x || o
  end
  
  def full?
   @board.all? {|index| index == "X" || index == "O"}
  end 
  

  def draw?
   if full? && !(won?)
     true 
   end 
  end 
  
  def over?
   if won? || draw?
     true 
   elsif !(won?) && !(draw?) || !(full?)
     false 
   end 
  end 
  
  def winner
    if won? 
      board[won?[0]] == "X" ? "X" : "O"
    else 
      nil 
    end 
  end 
  
  def play 
    until over?
      turn 
    end

    if winner == "X" || winner == "O"
      puts "Congratulations #{winner}!"
    elsif over? == true && draw? == true
      puts "Cat's Game!"
    end 
  end 
end 