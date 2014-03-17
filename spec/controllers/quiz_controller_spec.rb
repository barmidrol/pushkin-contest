require 'spec_helper'

describe QuizController do

  describe '#answer' do
    let(:task) { Task.new(id: 42) }

    it 'should render an error message if user not found' do
      post :answer, token: 'abcd', format: :json
      errors = JSON.parse(response.body)["errors"]
      errors.should_not be_blank
      errors.should include("User does not exist")
    end

    it 'should render an error message if task is answered' do
      task.stub(answered?: true)
      QuizAnswerRequest.any_instance.stub(task: task)

      post :answer, format: :json
      errors = JSON.parse(response.body)["errors"]
      errors.should_not be_blank
      errors.should include("Task is expired")
    end

    it 'should render an error if answer is blank' do
      post :answer, format: :json
      errors = JSON.parse(response.body)["errors"]
      errors.should_not be_blank
      errors.should include("Answer can't be blank")
    end

    it 'should render and error if task id is blank' do
      post :answer, format: :json
      errors = JSON.parse(response.body)["errors"]
      errors.should_not be_blank
      errors.should include("Task can't be blank")
    end
  end
end
