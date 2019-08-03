class AddPracticesWeightColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :practices, :weight, :integer
  end
end
