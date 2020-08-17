# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :description, :name, presence: true
  belongs_to :blog
end
