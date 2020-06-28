require './lib/game.rb'

describe Game do
  describe '#new'

    it 'can load a previous save' do
      @game = Game.new(Board.new)
      game = double(Game)
      allow(@game).to receive(:get_response) {"LOAD"}
      allow(File).to receive(:open).with('../saved_games/saved_game.yml', 'r').and_return(game)
      expect(game).to receive(:play_round)
      @game.new
    end

    it 'starts a round' do
      @game = Game.new(Board.new)
      allow(@game).to receive(:get_response) {""}
      expect(@game).to receive(:play_round)
      @game.new
    end

  describe '#play_round'

    it 'ends the game if checkmate' do
      @game = Game.new(Board.new)
      allow(@game.board).to receive(:check_mate?) {true}
      expect(@game).to receive(:game_over)
      @game.play_round
    end

    it 'doesnt end the game if not in checkmate' do
      @game = Game.new(Board.new)
      allow(@game.board).to receive(:check_mate?) {false}
      allow(@game).to receive(:choose_piece) {[6,0]}
      expect(@game).not_to receive(:game_over)
      @game.play_round
    end

end