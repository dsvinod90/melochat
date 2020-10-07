# frozen_string_literal: true

module Services
  class CreateAdminRole
    include ActiveModel::Validations

    attr_reader :role, :admin_id

    validate :role_should_be_present
    validate :role_should_be_valid

    def initialize(admin_id, role)
      @role     = role
      @admin_id = admin_id
    end

    def process
      return unless valid?

      admin.update_attributes!(role_id: roles_mask)
    end

    private

    def admin
      @admin ||= Admin.find_by(id: admin_id)
    end

    def roles_mask
      role_index = Admin::RoleMapping::MAP[role.to_s]
      2**role_index
    end

    def role_should_be_present
      return if role.present?

      errors.add(:base, I18n.t('admin.role_not_present'))
      false
    end

    def role_should_be_valid
      return unless role.present?

      return if Admin::Roles::ALL.include?(role)

      errors.add(:base, I18n.t('admin.invalid_role'))
      false
    end
  end
end
