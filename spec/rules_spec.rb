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

    it ("does something") do
      expect(rules.score(:cooperate, :cooperate)).to eq([3,3])
    end
  end
end
