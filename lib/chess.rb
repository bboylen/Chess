require 'pry'
require_relative 'board.rb'
require_relative 'pieces.rb'
require_relative 'player.rb'
require_relative 'game.rb'


board = Board.new
game = Game.new(board)
#board.board[0][6].move_set([0,6],board)
#board.board[2][0] = board.board[7][4]
#board.board[2][0].move_set([2,0],board)
game.new




