require 'test_helper'

class SendgridTemplateTest < ActiveSupport::TestCase
  test 'does not save template when name is not present' do
    template = SendgridTemplate.new(name: nil, template_id: 'foo123', version: '1.0', code: 'foo')
    assert_not template.save, 'Name can\'t be blank'
  end

  test 'does not save template when template_id is not present' do
    template = SendgridTemplate.new(name: 'Foobar', template_id: nil, version: '1.0', code: 'foo')
    assert_not template.save, 'Template Id can\'t be blank'
  end

  test 'does not save template when version is not present' do
    template = SendgridTemplate.new(name: 'Foobar', template_id: 'foo123', version: nil, code: 'foo')
    assert_not template.save, 'Version can\'t be blank'
  end

  test 'does not save template when code is not present' do
    template = SendgridTemplate.new(name: 'Foobar', template_id: 'foo123', version: nil, code: nil)
    assert_not template.save, 'Code can\'t be blank'
  end

  test 'saves template when all details are provided' do
    template = SendgridTemplate.new(name: 'Foobar', template_id: 'foo123', version: '1.0', code: 'foo')
    assert template.save
  end
end
