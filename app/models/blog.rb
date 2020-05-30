class Blog < ApplicationRecord
    validates :title, :body, :author, :category, presence: true
end
