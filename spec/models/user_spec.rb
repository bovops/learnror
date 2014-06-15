require 'rails_helper'

describe User do
  it { should validate_presence_of :email }
  it { should have_many :questions }
  it { should have_many :answers }
  it { should have_many :identities }

  describe '.find_for_oauth' do
    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }


    context 'user already has identity' do
      it 'returns the user' do
        user.identities.create(provider: 'facebook', uid: '123456')
        expect( User.find_for_oauth(auth) ).to eq user
      end
    end

    context 'user has not identity' do

      context 'user already exists' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: user.email }) }

        it 'does not create new user' do
          expect { User.find_for_oauth(auth) }.to_not change(User, :count)
        end

        it 'creates identity for user' do
          expect { User.find_for_oauth(auth) }.to change(user.identities, :count).by(1)
        end

        it 'creates identity for user with provider and uid' do
          identity = User.find_for_oauth(auth).identities.first
          expect(identity.provider).to eq auth.provider
          expect(identity.uid).to eq auth.uid
        end

        it 'returns the user' do
          expect( User.find_for_oauth(auth) ).to be_a(User)
        end

      end

      context 'user does not exists' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: 'new@user.com' }) }

        context 'provider returns email' do
          it 'fills user email' do
            user = User.find_for_oauth(auth)
            expect(user.email).to eq auth.info[:email]
          end
        end

        context 'provider does not returns email' do
          let(:auth) { OmniAuth::AuthHash.new(provider: 'twitter', uid: '123456') }

          it 'generates email for user' do
            user = User.find_for_oauth(auth)
            expect(user.email).to eq "tmp_#{auth.uid}_#{auth.provider}@localdomain.com"
          end
        end

        it 'creates new user' do
          expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
        end

        it 'creates identity for user' do
          user = User.find_for_oauth(auth)
          expect(user.identities).to_not be_empty
        end

        it 'creates identity with provider and uid' do
          identity = User.find_for_oauth(auth).identities.first
          expect(identity.provider).to eq auth.provider
          expect(identity.uid).to eq auth.uid
        end

        it 'returns the user' do
          expect( User.find_for_oauth(auth) ).to be_a(User)
        end

      end

    end

  end

end
