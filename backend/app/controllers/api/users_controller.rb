class Api::UsersController < ApplicationController
  def show
    @user = current_user
    render :show, status: :ok
  end
end
