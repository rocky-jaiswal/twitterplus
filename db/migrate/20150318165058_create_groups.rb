class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.text :name, null: false
      t.references :user, type: "integer", null: false

      t.timestamps null: false
    end
  end
end
