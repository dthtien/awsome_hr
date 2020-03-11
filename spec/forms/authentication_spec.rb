require 'rails_helper'

RSpec.describe Authentication do

  context 'Validation', authentication: true do
    before do
      @authentication = Authentication.new
      @status = @authentication.save
    end

    it '.save should raise validating service' do
      expect(@status).to be false
    end

    it '.save should raise validating service' do
      expect(@authentication.errors.any?).to be true
    end
  end

  context 'Validation', authentication: true do
    before do
      @authentication = Authentication.new(
        username: 'username 1',
        password: '123123'
      )
      @status = @authentication.save
    end

    it '.save should raise validating service' do
      expect(@status).to be true
    end

    it '.save should raise validating service' do
      expect(@authentication.user.id).to equal User.last.id
    end
  end
end
