require 'spec_helper'

describe User do
  subject { User.new }

  before(:each) do
    subject.stub(:confirm_registration)
  end

  describe 'validations' do
    describe 'username' do
      it 'should not allow blank usernames' do
        expect(subject.errors_on(:username)).to include("can't be blank")
      end

      it 'should have not errors on username' do
        subject.username = "Whatever"
        expect(subject).to have(:no).error_on(:username)
      end

    end

    describe 'url' do

      it 'should not allow blank urls' do
        expect(subject.errors_on(:url)).to include("can't be blank")
      end

      it 'should allow only valid urls' do
        subject.url = "bla bla bla"
        expect(subject.errors_on(:url)).to include("Not valid URL")
      end

      it 'should allow heroku domains' do
        subject.url = "http://somedomain.puchkin.com"
        expect(subject).to have(1).error_on(:url)
      end

      it 'should have no url errors' do
        subject.url = "http://pushckinrocks.herokuapp.com"
        expect(subject).to have(:no).errors_on(:url)
      end

      it 'should not end with backslash' do
        subject.url = "http://pushckinrocks.herokuapp.com/"
        expect(subject).to have(1).error_on(:url)
      end

    end
  end
end
