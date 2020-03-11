require 'rails_helper'

RSpec.describe UserPresenter do
  before do
    @user1 = create(:user)
    @user2 = create(:user, username: 'test2', manager_id: @user1.id)
    @user3 = create(:user, username: 'test3')
  end

  context 'Search imployee of user', user_presenter: true do
    let(:params) do
      { type: UsersOperations::Index::EMPLOYEE_SEARCH }
    end

    before do
      params[:user] = @user1.id
      @index = UsersOperations::Index.new(params)
    end

    it 'Should return user1 as root' do
      expect(@index.records.first.id).to equal @user1.id
    end

    it 'Should return user2 as branch' do
      expect(@index.records.last.id).to equal @user2.id
    end

    it 'Should not return user3' do
      expect(@index.records).not_to include @user3
    end
  end

  context 'Search manager of user', user_presenter: true do
    let(:params) do
      { type: UsersOperations::Index::MANAGER_SEARCH }
    end

    before do
      params[:user] = @user2.id
      @index = UsersOperations::Index.new(params)
    end

    it 'Should return user1 as root' do
      expect(@index.records.first.id).to equal @user1.id
    end

    it 'Should return user2 as branch' do
      expect(@index.records.last.id).to equal @user2.id
    end

    it 'Should not return user3' do
      expect(@index.records).not_to include @user3
    end
  end

  context 'Relationship between', user_presenter: true do
    let(:params) do
      { type: UsersOperations::Index::REATIONSHIP_CHECK }
    end
    it 'Should return manager' do
      params[:user1] = @user1.id
      params[:user2] = @user2.id
      @index = UsersOperations::Index.new(params)
      expect(@index.records).to equal UsersOperations::Index::MANAGER
    end

    it 'Should subordinate' do
      params[:user2] = @user1.id
      params[:user1] = @user2.id
      @index = UsersOperations::Index.new(params)
      expect(@index.records).to equal UsersOperations::Index::SUBORDINATE
    end

    it 'Should not return non-relative' do
      params[:user2] = @user3.id
      params[:user1] = @user2.id
      @index = UsersOperations::Index.new(params)
      expect(@index.records).to equal UsersOperations::Index::NON_RELATIVE
    end
  end
end
