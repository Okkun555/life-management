class CreateExercises < ActiveRecord::Migration[7.2]
  def change
    create_table :exercises do |t|
      t.references :body_part, null: false, foreign_key: true
      t.string :name, null: false, comment: '種目名'
      t.string :description, comment: '説明'
      t.timestamps
    end
  end
end
