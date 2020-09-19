# frozen_string_literal: true

class Blog < ApplicationRecord
  module Categories
    TECH = 'tech'
    public_constant :TECH
    MUSIC = 'music'
    public_constant :MUSIC
    ALL = %w[tech music].freeze
    public_constant :ALL
  end

  validates :title, :body, :author, :category, presence: true
  validate :category_should_be_valid

  has_many :comments, dependent: :destroy

  has_one_attached :cover_photo

  belongs_to :admin

  private

  def category_should_be_valid
    return if Categories::ALL.include?(category)

    errors.add(:base, I18n.t('blogs.invalid_category')) unless category.blank?
  end
end
