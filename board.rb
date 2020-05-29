class Board 
  attr_accessor :board
  def initialize
    create_board
    assign_pieces(Player.new,Player.new)

  end

  def create_board
    @board= []
    8.times do |row|
      @board << []
      if row == 0 || row == 7
        @board[row] = [Rook.new, Knight.new, Bishop.new, Queen.new, King.new, Bishop.new, Knight.new, Rook.new]
      elsif row == 1 or row == 6
        8.times {@board[row] << Pawn.new}
      else 
        8.times {@board[row] << nil}
      end
    end
  end

  def assign_pieces(white,black)
    @board.each_with_index do |row,index|
      if index == 0 || index == 1
        row.each do |piece| 
          piece.color = "black"
          piece.set_symbol
          black.pieces << piece
        end
      elsif index == 6 || index == 7
        row.each do |piece| 
          piece.color = "white"
          piece.set_symbol
          white.pieces << piece
        end
      end
    end
  end

  def display
    @board.each do |row|
      row.each_with_index do |tile,index|
        print " | "
        if tile != nil
          print tile.symbol 
        else 
          print " "
        end
      end
      puts " |"
      puts " ---------------------------------"
    end
  end

end