class AddCategoryIdToItem < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :category_id, :integer
    add_column :items, :maker_id, :integer
  end
end
