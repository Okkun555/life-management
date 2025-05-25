class Api::MissionStatementController < ApplicationController
  def create
    render json: { message: "Hello, world!" }
  end
end
