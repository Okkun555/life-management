class CreateWorkouts < ActiveRecord::Migration[7.2]
  def change
    create_table :workouts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :body_part, null: false, foreign_key: true
      t.string :name, null: false, comment: '種目名'
      t.string :description, comment: '説明'
      t.timestamps
    end

    add_index :workouts, [:user_id, :body_part_id, :name], unique: true
  end
end
