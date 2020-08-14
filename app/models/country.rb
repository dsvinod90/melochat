# frozen_string_literal: true

class Country < ApplicationRecord
  validates :name, :slug, :code, presence: true
end
