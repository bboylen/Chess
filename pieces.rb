class Piece

end

class Pawn < Piece
  attr_accessor :symbol
  attr_writer :color

  def set_symbol
    if @color == "black"
      @symbol = "\u265f"
    else
      @symbol = "\u2659"
    end
  end
end

class Rook < Piece
  attr_accessor :symbol
  attr_writer :color

  def set_symbol
    if @color == "black"
      @symbol = "\u265c"
    else
      @symbol = "\u2656"
    end
  end
end

class Knight < Piece
  attr_accessor :symbol
  attr_writer :color

  def set_symbol
    if @color == "black"
      @symbol = "\u265e"
    else
      @symbol = "\u2658"
    end
  end
end

class Bishop < Piece
  attr_accessor :symbol
  attr_writer :color

  def set_symbol
    if @color == "black"
      @symbol = "\u265d"
    else
      @symbol = "\u2657"
    end
  end
end

class King < Piece
  attr_accessor :symbol
  attr_writer :color

  def set_symbol
    if @color == "black"
      @symbol = "\u265a"
    else
      @symbol = "\u2654"
    end
  end
end

class Queen < Piece
  attr_accessor :symbol
  attr_writer :color

  def set_symbol
    if @color == "black"
      @symbol = "\u265b"
    else
      @symbol = "\u2655"
    end
  end
end
