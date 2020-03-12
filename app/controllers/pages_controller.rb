class PagesController < ApplicationController
  def home
    #TODO: fix n + 1
    @users = User.includes(:employees).needed_fields
  end
end
