require_relative '../lib/rules.rb'
require_relative 'spec_helper.rb'

module PrisonersDilemma

  module Generators
    class << self

      def rantly; Rantly.singleton end

      def move
        rantly.choose :cooperate, :defect
      end

      INTEGER_MAX=(2**(0.size * 8 -2) -1) / 2 #copied from Rantly

      def rules(max=INTEGER_MAX)
        s = rantly.range(0    , max - 3)
        #puts "s = #{s}"
        p = rantly.range(s + 1, max - 2)
        #puts "p = #{p}"
        c = rantly.range(p + 1, max - 1)
        #puts "r = #{r}"
        t = rantly.range(c + 1, max)
        rantly.guard((2 * c) > (t + s))
        data = Rules.new(t,c,p,s)
        # TODO: add a shrink method to the returned object?

        data
      end
    end
  end
end
