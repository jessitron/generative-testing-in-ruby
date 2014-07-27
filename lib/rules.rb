
class Rules

  def initialize (temptation_to_defect, reward_for_mutual_cooperation, punishment_for_mutual_defection, suckers_payout)
    @r = reward_for_mutual_cooperation
  end

  def score(move1, move2)
    [@r,@r]
  end
end
