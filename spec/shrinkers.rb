require_relative '../lib/rules.rb'

module Shrinkers
  def self.shrink_like_i_say(r)
    def r.shrink
      #TODO: also shrink the second one
      Shrinkers.shrink_like_i_say([first.shrink, last])
    end

    def r.shrinkable?
      first.shrinkable?
    end
    r
  end

  def self.do_not_shrink(r)
    def r.shrinkable?
      false
    end
    r
  end
end

class PrisonersDilemma::Rules

  def shrinkable?
    if (stream_of_smaller_rules.first == nil)
      puts "Not shrinkable: #{self}"
      false
    else
      true
    end
  end

  def stream_of_smaller_rules
    stream_of_shrunken_data(@s).flat_map do |s|
      ps = stream_of_shrunken_data(@p).take_while { |p| p > s }
      ps.flat_map do |p|
        cs = stream_of_shrunken_data(@c).take_while { |c| c > p }
        cs.flat_map do |c|
          ts = stream_of_shrunken_data(@t).drop(1).take_while { |t| t > c}
          ts.flat_map { |t| #OMG I can't believe filter isn't defined
            if ((2 * c) > t + s)
              [t]
            else
              []
            end
          }.map do |t|
            Rules.new(t,c,p,s)
          end
        end
      end
    end
  end

  # can be static outside of here. this is general
  def stream_of_shrunken_data(start)
    Enumerator.new do |yielder|
      latest = start #boo, mutable state.
      yielder.yield latest #cheating! conceptually this is wrong
      while (latest.shrinkable?)
        latest = latest.shrink
        yielder.yield latest
      end
    end.lazy
  end

  def shrink
    r = stream_of_smaller_rules.first
    puts "shrinking to #{r}"
    r
  end
end
