require_relative '../lib/rules'
require 'rantly'
require 'rantly/rspec_extensions'

describe Rules do

  context "example-based tests" do
    subject { described_class.new(5, 3, 2, 1)  }

    it "scores the same for each player" do
      expect(subject.score(:cooperate, :cooperate)).to eq([3, 3])
    end
  end

  it "tests with properties" do
  property_of {
   Rules.new(5,3,2,1)
  }.check { |rules|
    opponent_move = :defect
      defection_score = rules.score(:defect, opponent_move).first
      cooperation_score = rules.score(:cooperate, opponent_move).first
      expect(defection_score).to be > cooperation_score
  }
  end
end
