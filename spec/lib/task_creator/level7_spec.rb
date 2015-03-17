require 'spec_helper'

describe TaskCreator::Level7 do
  subject { described_class.new }

  describe '#generate_task' do
    let(:poem) { Poem.new }
    let(:text)  { "Бог кровь" }

    before(:each) do
      Poem.stub_chain(:random, :first).and_return(poem)

      poem.content = text
      poem.id = 42
    end

    it 'should pick a poem and create right task' do
      subject.generate_task

      options = text.split(//).permutation.to_a.map(&:join)

      10.times { options.should include(subject.task.question) }

      subject.task.answer.should == text

      subject.task.poem_id.should == poem.id
    end

  end

end
