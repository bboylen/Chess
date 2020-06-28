require 'pry'
require_relative 'board.rb'
require_relative 'pieces.rb'
require_relative 'player.rb'
require_relative 'game.rb'


board = Board.new
game = Game.new(board)
#game.board.board[4][4] = game.board.board[6][4]
#game.board.board[4][4].position = [4,4]
#game.board.board[3][3] = game.board.board[1][3]
#game.board.board[3][3].position = [1,3]
game.new




