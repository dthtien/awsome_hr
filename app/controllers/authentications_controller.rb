class AuthenticationsController < ApplicationController
  skip_before_action :authenticate_user!, except: %i[destroy]

  def new
    @authentication = Authentication.new
  end

  def create
    @authentication = Authentication.new(authentication_params)
    if @authentication.save
      log_in(@authentication.user)
      redirect_back_or root_path, notice: t('.success')
    else
      flash[:alert] = @authentication.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path, notice: t('.logged_out')
  end

  private

  def authentication_params
    params.require(:authentication).permit(:username, :password)
  end
end