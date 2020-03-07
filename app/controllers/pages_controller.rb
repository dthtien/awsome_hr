class PagesController < ApplicationController
  def home
    #TODO: fix n + 1
    @users = User.includes(:employees)
                .select(:name, :manager_id, :id)
                .all.map do |user|
                  UserPresenter.new user
                end
  end
end
