require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  test 'should not save blog without title' do
    blog = Blog.new(title: nil, body: 'foo', author: 'Melo', category: 'Food')
    assert_not blog.save
  end

  test 'should not save blog without body' do
    blog = Blog.new(title: 'Foo', body: '', author: 'Melo', category: 'Food')
    assert_not blog.save
  end

  test 'should not save blog without author' do
    blog = Blog.new(title: 'Foo', body: 'foobar', author: nil, category: 'Food')
    assert_not blog.save
  end

  test 'should not save blog without category' do
    blog = Blog.new(title: 'Foo', body: 'foobar', author: 'Melo', category: '')
    assert_not blog.save
  end

  test 'should not save if blog category is not valid' do
    blog = Blog.new(title: 'Foo', body: 'foobar', author: 'Melo', category: 'Airplane')
    assert_not blog.save
  end

  test 'should save blog' do
    blog = Blog.new(title: 'Foo', body: 'foobar', author: 'Melo', category: 'food')
    assert blog.save
  end
end
