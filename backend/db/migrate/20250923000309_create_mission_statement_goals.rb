class CreateMissionStatementGoals < ActiveRecord::Migration[7.2]
  def change
    create_table :mission_statement_goals do |t|
      t.references :user, null: false, foreign_key: true, comment: 'ユーザーID'
      t.references :mission_statement_role, null: false, foreign_key: true, comment: '役割ID'
      t.string :goal, null: false, limit: 140, comment: '目標'

      t.timestamps
    end
  end
end
