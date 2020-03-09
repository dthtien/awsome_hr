class SearchesController < ApplicationController
  DEFAULT_PER_PAGE = 10

  def show
    @users = User.needed_fields.search(params[:q])

    respond_to do |format|
      format.html
      format.json { render json: @users.limit(DEFAULT_PER_PAGE) }
    end
  end
end
