class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :body
      t.string :category
      t.string :author

      t.timestamps
    end
  end
end
