require 'yaml'
require_relative 'player.rb'
require_relative 'board.rb'
require_relative 'pieces.rb'
require 'pry'

class Game
  attr_accessor :board

  def initialize(board)
    @board = board
    @turn = board.white
    @not_turn = board.black
  end

  def new 
    puts 
    puts "Welcome, to move please enter the space containing the piece you wish to move (e.g. A4),"
    puts "hit ENTER, then choose the destination"
    puts "Type 'SAVE' at any time to save the game"
    puts "Type LOAD to load the previous save"
    puts "Otherwise hit ENTER and White will begin"
    return load_game if get_response == "LOAD"
    puts puts
    play_round
  end

  def play_round 
    @board.display
    if @board.check_mate?(@turn, @not_turn)
      return game_over
    elsif @board.check?(@turn.king.position, @not_turn.pieces)
      puts
      puts "You are in check"
    end
    piece_choice = choose_piece
    piece_destination = choose_destination(piece_choice)
    puts puts 
    @turn, @not_turn = @not_turn, @turn
    play_round
  end

  def choose_destination(piece_choice) 
    puts "Where do you want to move it?"
    choice_valid = false
    starting_king_position = @turn.king.position
    piece_moving = @board.board[piece_choice[0]][piece_choice[1]]
    while !choice_valid
      choice_string = get_response
      save(choice_string)

      if @board.row_hash.has_key?(choice_string[1]) && @board.column_hash.has_key?(choice_string[0])
        choice = [@board.row_hash[choice_string[1]], @board.column_hash[choice_string[0]]]
        piece_captured = @board.board[choice[0]][choice[1]]
        if piece_moving.move_set(board).include?(choice)
          @board.board[piece_choice[0]][piece_choice[1]] = nil
          @board.board[choice[0]][choice[1]] = piece_moving
          piece_moving.position = choice
          if board.check?(@turn.king.position,@not_turn.pieces)
            puts "Move invalid. Would place King in Check."
            @turn.king.position = starting_king_position
            @board.board[choice[0]][choice[1]] = piece_captured
            @board.board[piece_choice[0]][piece_choice[1]] = piece_moving
            piece_choice = choose_piece
            piece_captured = choose_destination(piece_choice)
            choice_valid = true
          else
            choice_valid = true
            @not_turn.pieces.delete(piece_captured)
            piece_moving.moves_made += 1
          end
        end
      end
    end
    choice
  end

  private

  def choose_piece
    choice_valid = false
    while !choice_valid
      puts
      puts "Please select a #{@turn.team} piece."
      choice_string = get_response
      save(choice_string)

      if @board.row_hash.has_key?(choice_string[1]) && @board.column_hash.has_key?(choice_string[0])
        choice = [@board.row_hash[choice_string[1]], @board.column_hash[choice_string[0]]]
        piece = @board.board[choice[0]][choice[1]]
        if piece
          choice_valid = true if piece.color == @turn.team && piece.move_set(board).empty? == false
        end
      end
    end
    choice
  end

  def get_response(response = gets.chomp)
    response
  end

  def game_over
    puts
    puts "Game over! #{@not_turn.team} is the winner!"
  end

  def save(string)
    if string == "SAVE"
      File.open("../saved_games/saved_game.yml", "w") {|save_file| save_file.puts YAML.dump(self)}
      puts "Game is saved"
    end
  end

  def load_game
    game = File.open("../saved_games/saved_game.yml", "r") {|save_file| YAML.load(save_file)} 
    game.play_round
  end

end
