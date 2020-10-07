# frozen_string_literal: true

class Admin < ApplicationRecord
  module Roles
    PUBLISHER   = 'publisher'
    SUPER_ADMIN = 'super_admin'
    ALL         = [PUBLISHER, SUPER_ADMIN].freeze
  end

  module RoleMapping
    MAP = {
      Roles::PUBLISHER => 1,
      Roles::SUPER_ADMIN => 2
    }.freeze
  end

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :timeoutable,
         :confirmable

  has_many :blogs
end
