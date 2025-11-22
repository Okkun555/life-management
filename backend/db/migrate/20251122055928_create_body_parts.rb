class CreateBodyParts < ActiveRecord::Migration[7.2]
  def change
    create_table :body_parts do |t|
      t.string :name, null: false, comment: '部位名'
      t.string :ancestry, null: false, comment: '階層'

      t.timestamps
    end
    add_index :body_parts, :ancestry
  end
end
