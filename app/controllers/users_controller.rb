class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.includes(:employees).find_by(id: params[:id]) || current_user
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

  private

  def user_params
    params.require(:user).permit(
      :name, :username, :manager_id, :password, :password_confirmation
    )
  end
end
