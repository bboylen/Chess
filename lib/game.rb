class Game
  attr_accessor :board

  def initialize(board)
    @board = board
    @white = board.white
    @black = board.black
    @turn = @white
  end

  def new
    puts "Welcome, to move please enter the space containing the piece you wish to move (e.g. A4), hit ENTER, then choose the destination"
    puts "White will begin"
    puts puts
    play_round
  end

  def play_round
    @board.display
    piece_choice = choose_piece
    puts "Where do you want to move it?"
    piece_destination = choose_destination(piece_choice)
    @board.move(piece_choice, piece_destination)
    puts puts puts
    @board.display
    if @turn = @white
      @turn = @black
    else
      @turn = @white
    end
    #remove piece from player pieces array?
  end

  def choose_piece
    choice_valid = false
    while !choice_valid
      puts
      puts "Please select a #{@turn.team} piece."
      choice_string = gets.chomp
      choice = [@board.row_hash[choice_string[1]], @board.column_hash[choice_string[0]] ]
      piece = @board.board[choice[0]][choice[1]]
      if piece
        choice_valid = true if piece.color == @turn.team && piece.move_set(choice,board).empty? == false
      end
    end
    choice
  end

  def choose_destination(piece_choice)
    choice_valid = false
    while !choice_valid
      choice_string = gets.chomp
      choice = [@board.row_hash[choice_string[1]], @board.column_hash[choice_string[0]] ]
      choice_valid = true if @board.board[piece_choice[0]][piece_choice[1]].move_set(piece_choice, board).include?(choice)
    end
    choice
  end
end