class CreateSendgridTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :sendgrid_templates do |t|
      t.string :name
      t.string :code
      t.string :template_id
      t.string :version

      t.timestamps
    end
  end
end
