require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "POST #create" do
    context "with valid params" do
      it 'redirects to goals index' do
        post :create, params: { user: { username: 'haseeb', password: 'royal_flush1337'} }
        expect(response).to redirect_to goals_url
      end
    end

    context "with invalid params" do
      it 'renders new user template' do
        post :create, params: { user: { username: 'haseeb', password: ''} }
        expect(response).to render_template :new
      end

      it 'validates uniqueness of username' do
        post :create, params: { user: { username: 'haseeb', password: 'royal_flush1337'} }
        post :create, params: { user: { username: 'haseeb', password: 'royal_1337'} }
        expect(flash[:errors]).to be_present
      end

      it 'validates that the password is at least 6 characters long' do
        post :create, params: { user: { username: 'haseeb', password: ''} }
        expect(flash[:errors]).to be_present
      end
    end
  end

end
