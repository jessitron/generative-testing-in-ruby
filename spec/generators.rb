require_relative '../lib/rules.rb'
require_relative 'spec_helper.rb'

module PrisonersDilemma

      class Rules
        #if a shrink method exists, barf
        def shrinkable?
          if( stream_of_smaller_rules.first == nil)
            puts "Not shrinkable: #{self}"
            false
          else
            true
          end
        end
        def stream_of_smaller_rules
          stream_of_shrunken_data(@s).flat_map { |s|
            ps = stream_of_shrunken_data(@p).take_while { |p| p > s }
            ps.flat_map { |p|
              cs = stream_of_shrunken_data(@c).take_while { |c| c > p }
              cs.flat_map { |c|
                ts = stream_of_shrunken_data(@t).drop(1).take_while { |t| t > c}
                ts.flat_map { |t| #OMG I can't believe filter isn't defined
                  if ((2 * c) > t + s)
                    [t]
                  else
                    []
                  end
                }.map { |t|
                   Rules.new(t,c,p,s)
                }
              }
            }
          }
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
  class Generators
    class << self

      INTEGER_MAX=(2**(0.size * 8 -2) -1) / 2 #copied from Rantly

      def rules(max=INTEGER_MAX)
        rantly = Rantly.singleton
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
