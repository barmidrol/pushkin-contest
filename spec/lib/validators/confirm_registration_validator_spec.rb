require 'spec_helper'

describe ConfirmRegistrationValidator do

  subject { ConfirmRegistrationValidator.new(attributes: {}) }
  let(:model) { Object.new }
  let(:errors) { ActiveModel::Errors.new(model) }

  before(:each) do
    model.stub(token: '123', errors: errors)
  end

  it "should not perfom any validations if model have errors" do
    errors.add(:name, '')
    RestClient.should_not_receive(:post)
    subject.validate(model)
  end

  it "should go through validation process and recieve valid answer", vcr: true do
    model.stub(url: 'http://localhost:3000')
    subject.validate(model)
    expect(model.errors).to have(:no).errors_on(:url)
  end
end
