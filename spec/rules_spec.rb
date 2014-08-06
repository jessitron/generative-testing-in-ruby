require_relative 'spec_helper'
require_relative '../lib/rules'

describe PrisonersDilemma::Rules do

  context 'example-based tests' do
    subject { described_class.new(5, 3, 2, 1) }

    it 'scores the same for each player' do
      expect(subject.score(:cooperate, :cooperate)).to eq([3, 3])
    end
  end

#  it 'shrinks' do
#    property_of {
#      integer
#    }.check do |i|
#      expect(i).to be > 0
#    end
#  end


  it 'Defection is always better for me' do
    property_of {
     Generators.of_two(Generators.rules, Generators.move).sample
    }.check do |( rules, opponent_move )|
      defection_score = rules.score(:defect, opponent_move).first
      cooperation_score = rules.score(:cooperate, opponent_move).first
      expect(defection_score).to be > cooperation_score
    end
  end

  it 'Mutual Cooperation is the best possible outcome' do
    property_of {
      Generators.of_two(Generators.move, Generators.move).filter(->(v) {v != [:cooperate, :cooperate]}).sample
    }.check do |(move1,move2)|
      false
    end
  end
end
