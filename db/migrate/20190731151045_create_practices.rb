class CreatePractices < ActiveRecord::Migration[5.2]
  def change
    create_table :practices do |t|
      t.string :bar_type
      t.string :moving
      t.integer :amount
      t.integer :unit
      t.float :rest

      t.timestamps
    end
  end
end
