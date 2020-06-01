class Board 
  attr_accessor :board, :column_hash, :row_hash
  attr_reader :white, :black
  def initialize
    create_board
    @white = Player.new('white')
    @black = Player.new('black')
    assign_pieces(@white,@black)
    @column_hash = {"A" => 0, "B" => 1, "C" => 2, "D" => 3, 
      "E" => 4, "F" => 5, "G" => 6, "H" => 7}
    @row_hash = {"8" => 0, "7" => 1, "6" => 2, "5" => 3, 
      "4" => 4, "3" => 5, "2" => 6, "1" => 7}

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
    @board.each_with_index do |row, index|
      print "#{8 - index}"
      row.each do |tile|
        print " | "
        if tile != nil
          print tile.symbol 
        else 
          print " "
        end
      end
      puts " |"
      puts "  ---------------------------------"
    end
    print "    A   B   C   D   E   F   G   H"
  end

  def occupied?(position)
    if @board[position[0]][position[1]] == nil
      false
    else 
      true
    end
  end

  def occupied_by_same_team?(position, team)
    if @board[position[0]][position[1]] == nil || @board[position[0]][position[1]].color != team
      false
    else 
      true
    end
  end

  def out_of_bounds?(position)
    if position[0] < 0 || position[0] > 7 || position[1] < 0 || position[1] > 7
      true
    else
      false
    end
  end 

  def move(initial_position, end_position)
    @board[end_position[0]][end_position[1]] = @board[initial_position[0]][initial_position[1]]
    @board[initial_position[0]][initial_position[1]] = nil
  end

end