require 'spec_helper'

describe TaskCreator::Level4 do
  subject { described_class.new }
  let(:poem) { Poem.new }

  describe '#generate_task' do
    before(:each) do
      Poem.stub_chain(:random, :first).and_return(poem)
      subject.stub(:pick_word) { |string| subject.strip_punctuation(string.split(/\s/).first) }
      poem.id = 42
      poem.content = <<-TEXT
Скажи, дядя,
Ведь недаром,
Мocкву спалили?
TEXT
      subject.generate_task
    end

    it 'should pick a poem and create right task' do
      subject.task.answer.should == "скажи,ведь,мocкву"
      subject.task.question.should == "%WORD%, дядя,\n%WORD% недаром,\n%WORD% спалили?"

      subject.task.poem_id.should == poem.id
    end

  end

end
