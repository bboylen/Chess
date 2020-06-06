class Game
  attr_accessor :board

  def initialize(board)
    @board = board
    @white = board.white
    @black = board.black
    @white.king = @white.pieces.select {|piece| piece.instance_of?(King)}[0]
    @black.king = @black.pieces.select {|piece| piece.instance_of?(King)}[0]
    @turn = @white
    @not_turn = @black
  end

  def new
    puts puts
    puts "Welcome, to move please enter the space containing the piece you wish to move (e.g. A4), hit ENTER, then choose the destination"
    puts "White will begin"
    puts puts
    play_round
  end

  def play_round
    @board.display
    #binding.pry
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
      choice = [@board.row_hash[choice_string[1]], @board.column_hash[choice_string[0]]]
      piece = @board.board[choice[0]][choice[1]]
      #FIX INPUT CRASH
      if piece
        choice_valid = true if piece.color == @turn.team && piece.move_set(choice,board).empty? == false
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
      choice = [@board.row_hash[choice_string[1]], @board.column_hash[choice_string[0]]]
      piece_captured = @board.board[choice[0]][choice[1]]
      if piece_moving.move_set(piece_choice, board).include?(choice)
        @board.board[choice[0]][choice[1]] = piece_moving
        piece_moving.position = choice
        if board.check?(@turn.king.position,@not_turn.pieces)
          puts "Move invalid. Would place King in Check."
          @turn.king.position = starting_king_position
          @board.board[choice[0]][choice[1]] = piece_captured
          piece_choice = choose_piece
          piece_captured = choose_destination(piece_choice)
          choice_valid = true
        else
          choice_valid = true
          @board.board[piece_choice[0]][piece_choice[1]] = nil
          @not_turn.pieces.delete(piece_captured)
          piece_moving.moves_made += 1
        end
      end
    end
    choice
  end

  def game_over
    puts "Game over! #{@not_turn.team} is the winner!"
  end

end