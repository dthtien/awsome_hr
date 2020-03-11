require 'rails_helper'

RSpec.describe UsersOperations::Index do
  before do
    @user1 = create(:user)
    @user2 = create(:user, username: 'test2', manager_id: @user1.id)
    @user3 = create(:user, username: 'test3')
  end

  context '.decendants', search_imployee: true do
    before do
      @user = UserPresenter.new(@user1)
    end

    it 'Should return user1 as root' do
      expect(@user.descendants.keys).to include @user
    end

    before do
      @branch = @user.descendants.values.first.keys
    end

    it 'Should return user2 as branch' do
      expect(@branch).to include @user2
    end

    it 'Should not return user3' do
      expect(@branch).not_to include @user3
    end
  end

  context '.ancestors', search_imployee: true do
    before do
      @user = UserPresenter.new(@user2)
    end
    it 'Should return user1 as root' do
      expect(@user.ancestors.keys).to include @user1
    end

    before do
      @branch = @user.ancestors.values.first.keys
    end

    it 'Should return user2 as branch' do
      expect(@branch).to include @user2
    end

    it 'Should not return user3' do
      expect(@branch).not_to include @user3
    end
  end
end
