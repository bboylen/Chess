require 'json'
require 'yaml'
class Game
  attr_accessor :board

  def initialize(board)
    @board = board
    @turn = board.white
    @not_turn = board.black
    @turn.king = @turn.pieces.select {|piece| piece.instance_of?(King)}[0]
    @not_turn.king = @not_turn.pieces.select {|piece| piece.instance_of?(King)}[0]
  end

  def new
    puts 
    puts "Welcome, to move please enter the space containing the piece you wish to move (e.g. A4),"
    puts "hit ENTER, then choose the destination"
    puts "Type 'SAVE' at any time to save the game"
    puts "White will begin, type LOAD to load the previous save"
    puts "Otherwise hit ENTER to begin"
    choice = gets.chomp
    return load_game if choice == "LOAD"
    puts puts
    play_round
  end

  def play_round
    @board.display
    if board.check_mate?(@turn.king.position, @turn, @not_turn, @board)
      return game_over
    end
    if board.check?(@turn.king.position, @not_turn.pieces)
      puts
      puts "You are in check"
    end
    piece_choice = choose_piece
    piece_destination = choose_destination(piece_choice)
    puts puts 
    @turn, @not_turn = @not_turn, @turn
    play_round
  end

  def choose_piece
    choice_valid = false
    while !choice_valid
      puts
      puts "Please select a #{@turn.team} piece."
      choice_string = gets.chomp

      if choice_string == "SAVE"
        File.open("../saved_games/saved_game.yml", "w") {|save_file| save_file.puts YAML.dump(self)}
        puts "Game is saved"
      end

      if @board.row_hash.has_key?(choice_string[1]) && @board.column_hash.has_key?(choice_string[0])
        choice = [@board.row_hash[choice_string[1]], @board.column_hash[choice_string[0]]]
        piece = @board.board[choice[0]][choice[1]]
        choice_valid = true if piece.color == @turn.team && piece.move_set(board).empty? == false
      end
    end
    choice
  end

  def choose_destination(piece_choice)
    puts "Where do you want to move it?"
    choice_valid = false
    starting_king_position = @turn.king.position
    piece_moving = @board.board[piece_choice[0]][piece_choice[1]]
    while !choice_valid
      choice_string = gets.chomp

      if choice_string == "SAVE"
        File.open("../saved_games/saved_game.yml", "w") {|save_file| save_file.puts YAML.dump(self)}
        puts "Game is saved"
      end

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

  def game_over
    puts "Game over! #{@not_turn.team} is the winner!"
  end

  def load_game
    game = File.open("../saved_games/saved_game.yml", "r") {|save_file| YAML.load(save_file)} 
    game.play_round
  end

end
