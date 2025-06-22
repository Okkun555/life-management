class Api::MissionStatementController < ApplicationController
  def create
    mission_statement = MissionStatement.new(mission_statement_params)

    if mission_statement.save
      render json: mission_statement, status: :created
    else
      render json: { errors: mission_statement.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def mission_statement_params
    params.permit(:name)
  end
end
