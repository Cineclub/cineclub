# frozen_string_literal: true

require 'rails_helper'

describe 'E-mail confirmations API', type: :request do
  describe 'PUT /confirm_email' do
    before { create(:user, email_confirmation_token: 'dummytoken') }

    context 'when the token matches a user' do
      it 'confirms the user' do
        put confirm_email_path(token: 'dummytoken')
        expect(User.last.email_confirmed_at).to be_present
      end
    end

    context 'when the token does not match a user' do
      it 'confirms the user' do
        put confirm_email_path(token: 'differenttoken')
        expect(User.last.email_confirmed_at).to be_nil
      end
    end
  end
end
