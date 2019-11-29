class CreateFixedcosts < ActiveRecord::Migration[5.0]
  def change
    create_table :fixedcosts do |t|
      t.string :name, null: false
      t.string :description
      t.timestamps
    end
  end
end
