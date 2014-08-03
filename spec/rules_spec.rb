require_relative '../lib/rules'

describe Rules do

  context "suckers interact with each other" do
    subject { described_class.new(5, 3, 2, 1)  }

    it "scores the same for each player" do
      expect(subject.score(:cooperate, :cooperate)).to eq([3, 3])
    end
  end

  generative do
    data(:rules) { Rules.new(5,3,2,1) }
    data(:opponent_move) { :cooperate }

    it ("defection always better for me") do
      defection_score = rules.score(:defect, opponent_move).first
      cooperation_score = rules.score(:cooperate, opponent_move).first
      expect(defection_score).to be > cooperation_score
    end
  end
end
