class Piece
  attr_accessor :moves_made, :symbol, :color, :position
  

  def initialize
    @moves_made = 0
  end

end

class Pawn < Piece

  def set_symbol
    if @color == "black"
      @symbol = "\u265f"
    else
      @symbol = "\u2659"
    end
  end

  def move_set(position, board)
    move_set = []
    if @moves_made == 0
      move_set += [[position[0] - 1, position[1]], [position[0] - 2, position[1]]] if @color == "white"
      move_set += [[position[0] + 1, position[1]], [position[0] + 2, position[1]]] if @color == "black"
    else 
      move_set += [[position[0] - 1, position[1]]] if @color == "white"
      move_set += [[position[0] + 1, position[1]]] if @color == "black"
    end
    move_set.delete_if {|tile| board.occupied?(tile) || board.out_of_bounds?(tile)}

    move_set += pawn_capture(position,board)
    #move_set.delete_if {|tile| board.out_of_bounds?(tile)}
    #print move_set
    move_set
  end

private 

  def pawn_capture(position, board)
    enemy_location = []
    move_set = []
    if @color == "white"
      enemy_location = [position[0] - 1, position[1] - 1]
      if board.board[enemy_location[0]][enemy_location[1]]
        move_set += [enemy_location] if board.board[enemy_location[0]][enemy_location[1]].color == "black"
      end
      enemy_location = [position[0] - 1, position[1] + 1]
      if board.board[enemy_location[0]][enemy_location[1]]
        move_set += [enemy_location] if board.board[enemy_location[0]][enemy_location[1]].color == "black"
      end
    else
      enemy_location = [position[0] + 1, position[1] - 1]
      if board.board[enemy_location[0]][enemy_location[1]]
        move_set += [enemy_location] if board.board[enemy_location[0]][enemy_location[1]].color == "white"
      end
      enemy_location = [position[0] + 1, position[1] + 1]
      if board.board[enemy_location[0]][enemy_location[1]]
        move_set += [enemy_location] if board.board[enemy_location[0]][enemy_location[1]].color == "white"
      end
    end
    move_set
  end
end

class Rook < Piece

  def set_symbol
    if @color == "black"
      @symbol = "\u265c"
    else
      @symbol = "\u2656"
    end
  end

  def move_set(position, board)
    move_set = []
    move_set += sliding_positions(position, board, [-1,0])
    move_set += sliding_positions(position, board, [1,0])
    move_set += sliding_positions(position, board, [0,-1])
    move_set += sliding_positions(position, board, [0,1])
    move_set
  end

  def sliding_positions(position, board, direction)
    move_set = []
    done = false
    while !done
      next_position = [position[0] + direction[0], position[1] + direction[1]]
      break if board.out_of_bounds?(next_position)
      if board.board[next_position[0]][next_position[1]].nil?
        move_set << next_position 
        position = next_position
      elsif board.occupied?(next_position) && !board.occupied_by_same_team?(next_position, @color)
        move_set << next_position
        done = true
      else 
        done = true
      end
    end
    move_set
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

  def move_set(position, board)
  move_set = [[position[0] + 1, position[1] + 2],
              [position[0] + 1, position[1] - 2],
              [position[0] + 2, position[1] + 1],
              [position[0] + 2, position[1] - 1],
              [position[0] - 1, position[1] + 2],
              [position[0] - 1, position[1] - 2],
              [position[0] - 2, position[1] + 1],
              [position[0] - 2, position[1] - 1]]
  move_set.delete_if {|tile| board.out_of_bounds?(tile)}           
  move_set.delete_if {|tile| board.occupied_by_same_team?(tile, @color)}
  move_set
  end
end

class Bishop < Piece

  def set_symbol
    if @color == "black"
      @symbol = "\u265d"
    else
      @symbol = "\u2657"
    end
  end

  def move_set(position, board)
    move_set = []
    move_set += sliding_positions(position, board, [-1,-1])
    move_set += sliding_positions(position, board, [-1,1])
    move_set += sliding_positions(position, board, [1,-1])
    move_set += sliding_positions(position, board, [1,1])
    move_set
  end

  def sliding_positions(position, board, direction)
    move_set = []
    done = false
    while !done
      next_position = [position[0] + direction[0], position[1] + direction[1]]
      break if board.out_of_bounds?(next_position)
      if board.board[next_position[0]][next_position[1]].nil? 
        move_set << next_position 
        position = next_position
      elsif board.occupied?(next_position) && !board.occupied_by_same_team?(next_position, @color)
        move_set << next_position
        done = true
      else 
        done = true
      end
    end
    move_set
  end
end

class King < Piece

  def set_symbol
    if @color == "black"
      @symbol = "\u265a"
    else
      @symbol = "\u2654"
    end
  end

  def move_set(position, board)
    move_set = [[position[0] + 1, position[1]],
                [position[0] + 1, position[1] + 1],
                [position[0] + 1, position[1] - 1],
                [position[0] - 1, position[1]],
                [position[0] - 1, position[1] + 1],
                [position[0] - 1, position[1] - 1],
                [position[0], position[1] + 1],
                [position[0], position[1] - 1]]
    move_set.delete_if {|tile| board.out_of_bounds?(tile)}           
    move_set.delete_if {|tile| board.occupied_by_same_team?(tile, @color)}
    move_set
    end

end

class Queen < Piece

  def set_symbol
    if @color == "black"
      @symbol = "\u265b"
    else
      @symbol = "\u2655"
    end
  end

  def move_set(position, board)
    move_set = []
    move_set += sliding_positions(position, board, [-1,0])
    move_set += sliding_positions(position, board, [1,0])
    move_set += sliding_positions(position, board, [0,-1])
    move_set += sliding_positions(position, board, [0,1])
    move_set += sliding_positions(position, board, [-1,-1])
    move_set += sliding_positions(position, board, [-1,1])
    move_set += sliding_positions(position, board, [1,-1])
    move_set += sliding_positions(position, board, [1,1])
    move_set
  end

  def sliding_positions(position, board, direction)
    move_set = []
    done = false
    while !done
      next_position = [position[0] + direction[0], position[1] + direction[1]]
      break if board.out_of_bounds?(next_position)
      if board.board[next_position[0]][next_position[1]].nil?
        move_set << next_position 
        position = next_position
      elsif board.occupied?(next_position) && !board.occupied_by_same_team?(next_position, @color)
        move_set << next_position
        done = true
      else 
        done = true
      end
    end
    move_set
  end
end
