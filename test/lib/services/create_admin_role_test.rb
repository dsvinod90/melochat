# frozen_string_literal: true

require('test_helper')

module Services
  class CreateAdminRoleTest < ActiveSupport::TestCase
    test 'returns nil when role is not present' do
      admin = admins(:admin_one)
      service = Services::CreateAdminRole.new(admin.id, nil)

      assert_nil(service.process)
    end

    test 'captures validation error when role is not present' do
      admin = admins(:admin_one)
      service = Services::CreateAdminRole.new(admin.id, ' ')
      service.process

      assert_includes(service.errors.full_messages, 'Role is not present')
    end

    test 'returns nil when role is invalid' do
      admin = admins(:admin_one)
      service = Services::CreateAdminRole.new(admin.id, 'Foobar')

      assert_nil(service.process)
    end

    test 'captures validation error when role is not valid' do
      admin = admins(:admin_one)
      service = Services::CreateAdminRole.new(admin.id, 'Foobar')
      service.process

      assert_includes(service.errors.full_messages, 'Admin role is not valid')
    end

    test 'saves role_id for publisher role' do
      admin = admins(:admin_one)
      service = Services::CreateAdminRole.new(admin.id, 'publisher')
      service.process

      assert_equal(admin.reload.role_id, 2)
    end

    test 'saves role_id for super_admin role' do
      admin = admins(:admin_one)
      service = Services::CreateAdminRole.new(admin.id, 'super_admin')
      service.process

      assert_equal(admin.reload.role_id, 4)
    end
  end
end
