
require 'spec_helper'

describe TaskCreator::Level5 do
  subject { described_class.new }
  let(:poem) { Poem.new }
  let(:text) { "Я ускользнул от Эскулапа"}
  let(:word) { "ускользнул" }
  let(:random_word) { "рука" }

  describe '#generate_task' do
    before(:each) do
      Poem.stub_chain(:random, :first).and_return(poem)
      subject.stub(pick_word: word)
      subject.stub(random_word: random_word)

      poem.content = text
      poem.id = 42
    end

    it 'should pick a poem and create right task' do
      subject.generate_task

      subject.task.answer.should == "#{word},#{random_word}"
      subject.task.question.should == "Я #{random_word} от Эскулапа"

      subject.task.poem_id.should == poem.id
    end

  end

end
