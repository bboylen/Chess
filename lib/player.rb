class Player
  attr_accessor :pieces, :team, :king
   
  def initialize(team)
    @team = team
    @pieces = []
  end
end