class Api::MissionStatementController < ApplicationController
  def create
    mission_statement = MissionStatement.new(content: params[:content])
    return unless mission_statement.save!

    render json: {
      message: 'ミッションステートメントを作成しました'
    }
  end
end
