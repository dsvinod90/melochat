# frozen_string_literal: true

class Admin < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :timeoutable,
         :confirmable
end
