require './lib/pieces.rb'

describe Pawn do
  
  describe '#move_set'

   it 'Returns the moves possible' do
    board = Board.new
    pawn = board.board[1][1]
    expect(pawn.move_set(board).include?([2,1])).to eql(true)
   end

   it 'Can move two space on first turn' do 
    board = Board.new
    pawn = board.board[1][1]
    expect(pawn.move_set(board).include?([3,1])).to eql(true)
    pawn.moves_made += 1
    expect(pawn.move_set(board).include?([3,1])).to eql(false)
   end

   it 'Can capture pieces' do 
    board = Board.new
    pawn = board.board[1][1]
    board.board[2][2] = board.board[7][0]
    expect(pawn.move_set(board).include?([2,2])).to eql(true)
    board.board[2][0] = board.board[7][0]
    expect(pawn.move_set(board).include?([2,0])).to eql(true)
    pawn = board.board[6][1]
    board.board[5][2] = board.board[1][0]
    expect(pawn.move_set(board).include?([5,2])).to eql(true)
    board.board[5][0] = board.board[1][0]
    expect(pawn.move_set(board).include?([5,0])).to eql(true)
    board.board[5][0] = nil
    expect(pawn.move_set(board).include?([5,0])).to eql(false)
   end
end

describe Rook do 

  describe '#move_set'

  it 'Returns the moves possible (and captures)' do
    board = Board.new
    rook = board.board[0][0]
    board.board[2][2] = board.board[0][0]
    rook.position = [2,2]
    board.board[2][4] = board.board[7][0]
    expect(rook.move_set(board).include?([2,4])).to eql(true)
    expect(rook.move_set(board).include?([6,2])).to eql(true)
    expect(rook.move_set(board).include?([2,1])).to eql(true)
  end
end


describe Bishop do 

  describe '#move_set'

  it 'Returns the moves possible (and captures)' do
    board = Board.new
    bishop = board.board[0][2]
    board.board[2][2] = board.board[0][2]
    bishop.position = [2,2]
    expect(bishop.move_set(board).include?([6,6])).to eql(true)
    expect(bishop.move_set(board).include?([4,0])).to eql(true)
    expect(bishop.move_set(board).include?([2,3])).to eql(false)
    expect(bishop.move_set(board).include?([3,2])).to eql(false)
  end
end

describe Queen do 

  describe '#move_set'

  it 'Returns the moves possible (and captures)' do
    board = Board.new
    queen = board.board[0][3]
    board.board[2][2] = board.board[0][3]
    queen.position = [2,2]
    board.board[2][4] = board.board[7][0]
    expect(queen.move_set(board).include?([2,4])).to eql(true)
    expect(queen.move_set(board).include?([6,2])).to eql(true)
    expect(queen.move_set(board).include?([6,6])).to eql(true)
    expect(queen.move_set(board).include?([4,0])).to eql(true)
    board.board[3][1] = board.board[1][3]
    expect(queen.move_set(board).include?([4,0])).to eql(false)
  end
end

describe Knight do 

  describe '#move_set'

  it 'Returns the moves possible (and captures)' do
    board = Board.new
    knight = board.board[0][1]
    board.board[4][4] = board.board[0][1]
    knight.position = [4,4]
    expect(knight.move_set(board).include?([6,3])).to eql(true)
    expect(knight.move_set(board).include?([6,5])).to eql(true)
    expect(knight.move_set(board).include?([5,6])).to eql(true)
    expect(knight.move_set(board).include?([3,6])).to eql(true)
    expect(knight.move_set(board).include?([5,2])).to eql(true)
    expect(knight.move_set(board).include?([3,2])).to eql(true)
    expect(knight.move_set(board).include?([2,3])).to eql(true)
    expect(knight.move_set(board).include?([2,5])).to eql(true)
    expect(knight.move_set(board).include?([5,5])).to eql(false)
  end
end

describe King do 

  describe '#move_set'

  it 'Returns the moves possible (and captures)' do
    board = Board.new
    king = board.board[0][4]
    board.board[5][4] = board.board[0][4]
    king.position = [5,4]
    expect(king.move_set(board).include?([6,4])).to eql(true)
    expect(king.move_set(board).include?([6,5])).to eql(true)
    expect(king.move_set(board).include?([6,3])).to eql(true)
    expect(king.move_set(board).include?([4,4])).to eql(true)
    expect(king.move_set(board).include?([4,3])).to eql(true)
    expect(king.move_set(board).include?([4,5])).to eql(true)
    expect(king.move_set(board).include?([5,3])).to eql(true)
    expect(king.move_set(board).include?([5,5])).to eql(true)
  end
end