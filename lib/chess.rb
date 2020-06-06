require 'pry'
require_relative 'board.rb'
require_relative 'pieces.rb'
require_relative 'player.rb'
require_relative 'game.rb'


board = Board.new
game = Game.new(board)
board.board[3][3] = board.board[0][4]
board.board[0][4] = nil
board.board[3][3].position = [3,3]
board.board[3][4] = board.board[7][3]
board.board[7][3] = nil
board.board[3][4].position = [3,4]
#board.board[3][2] = board.board[7][0]
#board.board[7][0] = nil
#board.board[3][2].position = [3,2]

game.new




