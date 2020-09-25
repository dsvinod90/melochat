require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'does not create user when name is not present' do
    user = User.new(name: nil, email: 'test@foobar.com')
    assert_not user.save, 'Name can\'t be blank'
  end

  test 'does not create user when email is not peresent' do
    user = User.new(name: 'Varun', email: nil)
    assert_not user.save, 'Email can\'t be blank'
  end

  test 'does not create user when email is not unique' do
    users(:melo)
    new_user = User.new(name: 'Varun', email: 'melodie@foobar.com')
    assert_not new_user.save, 'Email has already been taken'
  end

  test 'sets token for user before creating the user' do
    user = User.create(name: 'Mike Portnoy', email: 'mike@foobar.com')
    assert_not_nil(user.token)
  end

  test 'sets subscribed flag to true when user is created' do
    user = User.create(name: 'Mike Portnoy', email: 'mike@foobar.com')
    assert(user.subscribed)
  end
end
