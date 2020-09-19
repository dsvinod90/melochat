class AddAdminIdToBlogs < ActiveRecord::Migration[6.0]
  def change
    add_column :blogs, :admin_id, :integer
  end
end
