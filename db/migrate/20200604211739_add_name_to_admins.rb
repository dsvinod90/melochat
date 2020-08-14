# frozen_string_literal: true

class AddNameToAdmins < ActiveRecord::Migration[6.0]
  def change
    add_column(:admins, :name, :string)
  end
end
