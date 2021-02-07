require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'confirmation_email' do
    let(:user) { build(:user, email: 'johndoe@example.org', email_confirmation_token: 'dummytoken') }
    let(:mail) { UserMailer.confirmation_email(user) }

    it 'renders the headers' do
      expect(mail.subject).to eq 'Welcome to Cineclub'
      expect(mail.to).to eq ['johndoe@example.org']
      expect(mail.from).to eq ['from@example.com']
    end

    it 'renders the confirmation link' do
      confirmation_link = '<a href="http://localhost:3000/confirm_email/dummytoken">confirm e-mail address</a>'
      expect(mail.body.encoded.include?(confirmation_link)).to eq true
    end
  end
end
