require 'rails_helper'


RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe 'associations' do
    it { should have_many(:goals) }
    it { should have_many(:comments) }
    it { should have_many(:commented_goals).through(:comments) }
  end

  describe 'class methods' do
    describe '::find_by_credentials' do
      context 'with valid credentials' do
        it 'should return a user' do
          user_params = { username: 'mike', password: 'password' }
          j = User.new(user_params)
          j.save!
          expect(User.find_by_credentials('mike', 'password')).to eq(j)
        end
      end

      context 'with invalid credentials' do
        it 'should return nil' do
          user_params = { username: 'mike', password: 'password' }
          j = User.new(user_params)
          j.save!
          expect(User.find_by_credentials('mike', 'hunter12')).to be nil
        end
      end
    end
  end


end
