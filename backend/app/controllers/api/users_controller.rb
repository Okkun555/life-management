class Api::UsersController < ApplicationController
  def me
    @user = current_user
    render :show, status: :ok
  end
end
