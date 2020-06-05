class Country < ApplicationRecord
    validates :name, :slug, :code, presence: true
end
