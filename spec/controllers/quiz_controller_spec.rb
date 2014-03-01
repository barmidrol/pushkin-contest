require 'spec_helper'

describe QuizController do

  describe '#answer' do
    it 'should render an error message if user not found' do
      post :answer, token: 'abcd', format: :json
      errors = JSON.parse(response.body)["errors"]
      errors.should_not be_blank
      errors.should include("User does not exist")
    end

    it 'should render an error message if task is answered'
    it 'should render an error is answer is blank'
    it 'should render and error if task id is blank'
  end
end
