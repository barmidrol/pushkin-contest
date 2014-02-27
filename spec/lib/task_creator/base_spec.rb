require 'spec_helper'

describe TaskCreator::Base do
  subject { TaskCreator::Base.new }

  before(:each) { described_class.stub(level: 0) }

  describe '#pick_line' do
    let(:string) do <<-TEXT
Я не рожден святыню славословить,
Мой слабый глас не взыдет до небес;
Но должен я вас ныне приготовить
К услышанью Йоанниных чудес.
    TEXT
    end

    it 'should pick single line of text' do
      string.split("\n").should include(subject.pick_line(string).first)
    end

    it 'should pick 2 sequential lines of text' do
      lines = string.split("\n")
      [lines[0..1], lines[1..2], lines[2..3]].should include(subject.pick_line(string, 2))
    end

    it 'should pick 3 sequential lines of text' do
      lines = string.split("\n")
      [lines[0..2], lines[1..3]].should include(subject.pick_line(string, 3))
    end

    it 'should pick 4 sequential lines of text' do
      lines = string.split("\n")
      lines.should == subject.pick_line(string, 4)
    end

    it 'should pick 5 sequential lines of text' do
      lines = string.split("\n")
      lines.should == subject.pick_line(string, 5)
    end

  end


  describe '#pick_word' do
    let(:string) { "Мой слабый глас не взыдет до небес" }

    it 'should pick single word in line' do
      string.split(/\s/).should include(subject.pick_word(string))
    end

  end
end
