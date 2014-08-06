require_relative '../lib/rules'
require_relative 'spec_helper'

class Generator
  def initialize(how_to_produce)
    @produce = how_to_produce
  end

  def sample
    @produce.call
  end

  def filter(predicate)
    inner = self
    Generator.new -> do
      r = nil
      begin
        r = inner.sample
      end until predicate.(r)
      # consider using rantly.guard instead of looping
      r
    end
  end
end


module Generators
  class << self

    def of_two(gen1, gen2)
      Generator.new( ->() {
        r = [gen1.sample, gen2.sample]
        Shrinkers.shrink_like_i_say(r)
      })
    end

    def rantly; Rantly.singleton end

    def move
      Generator.new ->{rantly.choose :cooperate, :defect}
    end

    INTEGER_MAX=(2**(0.size * 8 -2) -1) / 2 #copied from Rantly

    def rules(max=INTEGER_MAX)
      Generator.new -> do
        s = rantly.range(0    , max - 3)
        #puts "s = #{s}"
        p = rantly.range(s + 1, max - 2)
        #puts "p = #{p}"
        c = rantly.range(p + 1, max - 1)
        #puts "r = #{r}"
        t = rantly.range(c + 1, max)
        rantly.guard((2 * c) > (t + s))
        PrisonersDilemma::Rules.new(t,c,p,s)
      end
    end
  end
end
