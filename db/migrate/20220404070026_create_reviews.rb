class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :item_id
      t.text :comment
      t.float :rate
      t.timestamps
    end
  end
end
