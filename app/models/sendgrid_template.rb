# frozen_string_literal: true

class SendgridTemplate < ApplicationRecord
  validates_presence_of :name, :template_id, :version, :code

  scope :newsletters, -> { where(code: 'HYP_NL') }
  scope :confirmation, -> { where(code: 'HYP_CONF_MAIL') }
  scope :latest_versions, -> { order('version desc') }

  module TemplateMappings
    NEWSLETTER   = 'HYP_NL'
    CONFIRMATION = 'HYP_CONF_MAIL'
  end
end
