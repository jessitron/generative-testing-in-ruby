require_relative 'spec_helper.rb'

module PrisonersDilemma
class Generators
  class << self

    INTEGER_MAX=(2**(0.size * 8 -2) -1) / 2 #copied from Rantly

  def rules(max=INTEGER_MAX)
    s = Rantly.range(0    , max - 3)
    p = Rantly.range(s + 1, max - 2)
    r = Rantly.range(r + 1, max - 1)
    t = Rantly.range(c + 1, max)
    Rantly.guard((2 * c) > (t + s))
    data = Rules.new(t,r,p,s)
    # TODO: add a shrink method to the returned object?
    data
  end
  end
end
end
