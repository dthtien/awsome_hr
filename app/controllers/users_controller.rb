class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def new
    @user = User.new
  end

  def index
    @index = UsersOperations::Index.new(params)
    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def edit; end

  def show
    @user = UserPresenter.new(User.find_by(id: params[:id]) || current_user)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: t('.success')
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: t('.success')
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :title, :name, :username, :manager_id, :password, :password_confirmation
    )
  end
end
