require 'spec_helper'

describe TaskCreator::Level2 do
  subject { described_class.new }
  let(:poem) { Poem.new }

  describe '#generate_task' do
    before(:each) do
      Poem.stub_chain(:random, :first).and_return(poem)
      poem.id = 42
      poem.content = "Языков, кто тебе внушил,"
      subject.generate_task
    end

    it 'should pick a poem and create right task' do
      ["языков", "кто", "тебе", "внушил"].should include(subject.task.answer)
      ["%WORD%, кто тебе внушил",
      "Языков, %WORD% тебе внушил",
      "Языков, кто %WORD% внушил",
      "Языков, кто тебе %WORD%"].should include(subject.task.question)
      subject.task.poem_id.should == poem.id
    end

  end

end
