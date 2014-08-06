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


  it 'tests with properties' do
    property_of {
     PrisonersDilemma::Shrinkers.shrink_like_i_say([PrisonersDilemma::Generators.rules, PrisonersDilemma::Generators.move])
    }.check do |( rules, opponent_move )|
      defection_score = rules.score(:defect, opponent_move).first
      cooperation_score = rules.score(:cooperate, opponent_move).first
      expect(defection_score).to be > cooperation_score
    end
  end
end
