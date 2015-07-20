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

    it 'should render an error message if task not found' do
      post :answer, task_id: -1, format: :json
      errors = JSON.parse(response.body)["errors"]
      errors.should_not be_blank
      errors.should include("Task does not exist")
    end

    it 'should render an error message if task is answered' do
      task.stub(answered?: true)
      QuizAnswerRequest.any_instance.stub(task: task)

      post :answer, format: :json
      errors = JSON.parse(response.body)["errors"]
      errors.should_not be_blank
      errors.should include("Task is expired")
    end

    it 'should render an error message if task is outdated' do
      task.stub(created_at: 1.day.ago)
      QuizAnswerRequest.any_instance.stub(task: task)

      post :answer, formate: :json
      errors = JSON.parse(response.body)["errors"]
      errors.should_not be_blank
      errors.should include("Task is outdated")
    end

    it 'should render an error message if task level differs from user level' do
      user = User.new
      user.stub(level: 1)
      task.stub(level: 2)
      QuizAnswerRequest.any_instance.stub(task: task, user: user)

      post :answer, format: :json
      errors = JSON.parse(response.body)["errors"]
      errors.should_not be_blank
      errors.should include("Task level mismatch")
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
