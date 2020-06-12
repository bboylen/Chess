require './lib/board.rb'

describe Board do
  describe '#initialize'

    it 'Creates an 8x8 board' do
      expect(subject.board[0].length).to eql(8)
      expect(subject.board.length).to eql(8)
    end

    it 'Places pieces in correct position' do
      subject.board[0].each do |piece|
        expect(piece.color).to eql("black")
      end
      subject.board[1].each do |piece|
        expect(piece.color).to eql("black")
      end
      subject.board[1].each do |piece|
        expect(piece.class).to eql(Pawn)
      end
      subject.board[6].each do |piece|
        expect(piece.color).to eql("white")
      end
      subject.board[6].each do |piece|
        expect(piece.class).to eql(Pawn)
      end
      subject.board[7].each do |piece|
        expect(piece.color).to eql("white")
      end
    end

    it 'Creates white and black players' do
      expect(subject.white.class).to eql(Player)
      expect(subject.white.pieces.length).to eql(16)
      expect(subject.black.class).to eql(Player)
      expect(subject.black.pieces.length).to eql(16)
    end

    it 'Sets position for Piece' do
      position = [0,1]
      expect(subject.board[position[0]][position[1]].position).to eql(position)
    end

  describe '#occupied'
    it 'Returns true if a tile has a piece' do
      expect(subject.occupied?([0,0])).to eql(true)
      expect(subject.occupied?([3,0])).to eql(false)
    end

  describe '#occupied_by_same_team?'
    it 'Returns true if tile is occupied by same team' do
      expect(subject.occupied_by_same_team?([0,0], "black")).to eql(true)
      expect(subject.occupied_by_same_team?([3,0], "black")).to eql(false)
      expect(subject.occupied_by_same_team?([7,0], "black")).to eql(false)
    end

  describe '#out_of_bounds?'
    it 'Returns true if inputted position is out of bounds' do
      expect(subject.out_of_bounds?([-1,0])).to eql(true)
      expect(subject.out_of_bounds?([1,9])).to eql(true)
      expect(subject.out_of_bounds?([9,0])).to eql(true)
      expect(subject.out_of_bounds?([3,-5])).to eql(true)
      expect(subject.out_of_bounds?([1,0])).to eql(false)
    end

  describe '#check?'
    it 'Returns true if the input king is in check' do
      expect(subject.check?([0,4], subject.white.pieces)).to eql(false)
      board = Board.new
      board.board[4][3] = board.board[7][4] 
      board.board[7][4].position = [4,3]
      board.board[4][5] = board.board[0][3] 
      board.board[0][3].position = [4,5]
      expect(board.check?([4,3], board.black.pieces)).to eql(true)
    end

  describe '#check_mate?'
    it 'Returns true if the input king is in check' do
      expect(subject.check_mate?(subject.white, subject.black)).to eql(false)
      board = Board.new
      board.board[4][3] = board.board[7][4] 
      board.board[7][4].position = [4,3]
      board.board[4][4] = board.board[0][3] 
      board.board[0][3].position = [4,4]
      board.board[4][2] = board.board[0][0] 
      board.board[0][0].position = [4,2]
      expect(subject.check_mate?(board.white, board.black)).to eql(true)
    end
end