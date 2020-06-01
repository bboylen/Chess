class Player
  attr_accessor :pieces, :team
   
  def initialize(team)
    @team = team
    @pieces = []
  end
end