class AddDescriptionToBlog < ActiveRecord::Migration[6.0]
  def change
    add_column :blogs, :description, :string
  end
end
