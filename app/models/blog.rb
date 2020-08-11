class Blog < ApplicationRecord
    module Categories
        TECH   = 'tech'.freeze
        MUSIC = 'music'.freeze
        ALL    = %w[tech music].freeze
    end

    validates :title, :body, :author, :category, presence: true
    validate :category_should_be_valid

    private

    def category_should_be_valid
        return if Categories::ALL.include?(category)

        errors.add(:base, I18n.t('blogs.invalid_category')) unless category.blank?
    end
end
