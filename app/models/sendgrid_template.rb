class SendgridTemplate < ApplicationRecord
  validates_presence_of :name, :template_id, :version, :code

  scope :newsletters, -> { where(code: 'HYP_NL') }
  scope :latest_versions, -> { order('version desc') }
end
