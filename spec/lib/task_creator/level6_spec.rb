require 'spec_helper'

describe TaskCreator::Level6 do
  subject { described_class.new }

  describe '#randomize_word' do
    let(:word) { 'word' }
    let(:options) { word.split(//).permutation.to_a.map(&:join) }

    it 'should shuffle letters in word' do
      options.should include(subject.randomize_word(word))
    end

  end

  describe '#generate_task' do
    let(:poem) { Poem.new }
    let(:stub_word)  { "stub" }

    before(:each) do
      Poem.stub_chain(:random, :first).and_return(poem)
      subject.stub(randomize_word: stub_word)

      poem.content = text
      poem.id = 42
    end

    describe 'without punctuation' do
      let(:text) { "Я ускользнул от Эскулапа"}

      it 'should pick a poem and create right task' do
        subject.generate_task

        subject.task.question.should == "stub stub stub stub"
        subject.task.answer.should == text

        subject.task.poem_id.should == poem.id
      end

    end

    describe 'without punctuation' do
      let(:text) { "Я ускользнул от Эскулапа!"}

      it 'should pick a poem and create right task' do
        subject.generate_task

        subject.task.question.should == "stub stub stub stub"
        subject.task.answer.should == "Я ускользнул от Эскулапа"

        subject.task.poem_id.should == poem.id
      end

    end



  end

end
