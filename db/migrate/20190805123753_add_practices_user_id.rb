class AddPracticesUserId < ActiveRecord::Migration[5.2]
  def change
    add_column :practices, :line_id, :string
  end
end
