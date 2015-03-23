require 'spec_helper'

describe TaskCreator::Level3 do
  subject { described_class.new }
  let(:poem) { Poem.new }

  describe '#generate_task' do
    before(:each) do
      Poem.stub_chain(:random, :first).and_return(poem)
      poem.id = 42
      poem.content = <<-TEXT
Скажи, дядя,
Ведь недаром?
TEXT
      subject.generate_task
    end

    it 'should pick a poem and create right task' do
      ['скажи,ведь', 'скажи,недаром', 'дядя,ведь', 'дядя,недаром'].should include(subject.task.answer)
      ["%WORD%, дядя,\n%WORD% недаром?",
       "%WORD%, дядя,\nВедь %WORD%?",
       "Скажи, %WORD%,\n%WORD% недаром?",
       "Скажи, %WORD%,\nВедь %WORD%?"].should include(subject.task.question)

      subject.task.poem_id.should == poem.id
    end

  end

end
