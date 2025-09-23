class CreateMissionStatementRoles < ActiveRecord::Migration[7.2]
  def change
    create_table :mission_statement_roles do |t|
      t.references :user, null: false, foreign_key: true, comment: 'ユーザーID'
      t.string :role, null: false, comment: '役割'

      t.timestamps
    end
  end
end
