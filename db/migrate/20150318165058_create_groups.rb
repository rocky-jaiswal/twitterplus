class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.text :name
      t.references :user, type: "integer"

      t.timestamps null: false
    end
  end
end
