# frozen_string_literal: true

require('test_helper')

class CountryTest < ActiveSupport::TestCase
  test 'does not save country when name is not present' do
    country = Country.new(name: nil, slug: 'in', code: 'IN')
    assert_not country.save, 'Name can\'t be blank'
  end

  test 'does not save country when slug is not present' do
    country = Country.new(name: 'India', slug: nil, code: 'IN')
    assert_not country.save, 'Slug can\'t be blank'
  end

  test 'does not save country when code is not present' do
    country = Country.new(name: 'India', slug: 'in', code: nil)
    assert_not country.save, 'Code can\'t be blank'
  end

  test 'does not save country when name is not blank' do
    country = Country.new(name: ' ', slug: 'in', code: 'IN')
    assert_not country.save, 'Name can\'t be blank'
  end

  test 'does not save country when slug is blank' do
    country = Country.new(name: 'India', slug: ' ', code: 'IN')
    assert_not country.save, 'Slug can\'t be blank'
  end

  test 'does not save country when code is blank' do
    country = Country.new(name: 'India', slug: 'in', code: ' ')
    assert_not country.save, 'Code can\'t be blank'
  end

  test 'saves country when all details are given' do
    country = Country.new(name: 'India', slug: 'in', code: 'IN')
    assert country.save
  end
end
