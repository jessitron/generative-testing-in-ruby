require_relative 'generators'
require 'spec_helper'

describe Generator do

  subject {
    described_class.new -> {
      rand(100)
    }
  }

  it 'tries to satisfy the predicate repeatedly' do
    foo = subject
    property_of {
      foo.filter(->(number) { number > 50 }).sample
    }.check do |value|
      expect(value).to be > 50
    end
  end
end
