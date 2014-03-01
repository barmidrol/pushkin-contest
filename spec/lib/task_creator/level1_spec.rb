require 'spec_helper'

describe TaskCreator::Level1 do
  subject { described_class.new }
  let(:poem) { Poem.new }


  describe '#generate_task' do
    before(:each) do
      Poem.stub_chain(:where, :random, :first).and_return(poem)
      poem.id = 42
      poem.content = <<-TEXT
Языков, кто тебе внушил,
Твое посланье удалое?
      TEXT
      poem.title = 'К языкову'
    end

    it 'should pick a poem and create right task' do
      subject.generate_task
      ["Языков, кто тебе внушил", "Твое посланье удалое"].should include(subject.task.question)
      subject.task.answer.should == poem.title.downcase
      subject.task.poem_id.should == poem.id
    end

  end

end
