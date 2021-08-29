require 'rails_helper'

RSpec.describe AccessToken, type: :model do
  describe '#validations' do
    it 'Have valid factory' do
      token = build :access_token
      expect(token).to be_valid
    end
    it 'should validate token' do
      token = build :access_token, token: nil
      expect(token).not_to be_valid
      expect(token.errors.messages[:token]).to include("can't be blank")
    end
    describe '#new' do
      it 'should have presence of a toke on creation' do
        expect(AccessToken.new.token).to be_present
      end
    end
  end
end
