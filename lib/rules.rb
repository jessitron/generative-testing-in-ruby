module PrisonersDilemma
  class Rules

    def initialize (temptation_to_defect, reward_for_mutual_cooperation, punishment_for_mutual_defection, suckers_payout)
      @t = temptation_to_defect
      @c = reward_for_mutual_cooperation
      @p = punishment_for_mutual_defection
      @s = suckers_payout
    end

    def score(move1, move2)
      [@c,@c]
    end

    def to_s
      "Rules(t=#{@t}, c=#{@c}, p=#{@p}, s=#{@s})"
    end

    def inspect
      to_s
    end
  end
end
