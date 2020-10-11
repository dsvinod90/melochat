class AddActiveToSendgridTemplates < ActiveRecord::Migration[6.0]
  def change
    add_column :sendgrid_templates, :active, :boolean
  end
end
