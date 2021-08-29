require 'rails_helper'

describe 'UserAuthenticator' do
  describe '#perform' do
    let(:auth) { UserAuthenticator.new('code_samp') }
    subject { auth.perform }
    context 'when code is not correct' do
      let(:error) { double('Sawyer::Resource', error: 'Bad verification code') }
      before do
        allow_any_instance_of(Octokit::Client).to receive(:exchange_code_for_token).and_return(error)
      end
      it 'rise an error' do
        expect { subject }.to raise_error(UserAuthenticator::AuthenticationError)
        expect(auth.user).to be_nil
      end
    end
    context 'when code is correct' do
      let(:user_data) do
        { name: 'Juan Pablo G', url: 'http://example.com/', avatar_url: 'http://example.com/avatar',
          login: 'JuanPabloG' }
      end
      before do
        allow_any_instance_of(Octokit::Client).to receive(:exchange_code_for_token).and_return('Valid Acces token')
        allow_any_instance_of(Octokit::Client).to receive(:user).and_return(user_data)
      end
      it 'rise an error' do
        expect { subject }.to change { User.count }.by(1)
        expect(User.last.name).to eq('Juan Pablo G')
      end

      it 'Should use already registered User' do
        user = create :user, user_data
        expect { subject }.not_to change { User.count }
        expect(auth.user).to eq(user)
      end

      it 'Should create and assign access token' do
        expect { subject }.to change { AccessToken.count }.by(1)
        expect(auth.access_token).to be_present
      end
    end
  end
end
