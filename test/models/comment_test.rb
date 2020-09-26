# frozen_string_literal: true

require('test_helper')

class CommentTest < ActiveSupport::TestCase
  test 'should not save comment without name' do
    blog = blogs(:music_sample)
    comment = Comment.new(name: nil, description: 'Foobar', blog: blog)
    assert_not comment.save, 'Name can\'t be blank'
  end

  test 'should not save comment with blank name' do
    blog = blogs(:tech_sample)
    comment = Comment.new(name: ' ', description: 'Foobar', blog: blog)
    assert_not comment.save, 'Name can\'t be blank'
  end

  test 'should not save comment without description' do
    blog = blogs(:music_sample)
    comment = Comment.new(name: 'Varun', description: nil, blog: blog)
    assert_not comment.save, 'Description can\'t be blank'
  end

  test 'should not save comment with blank description' do
    blog = blogs(:tech_sample)
    comment = Comment.new(name: 'Varun', description: ' ', blog: blog)
    assert_not comment.save, 'Description can\'t be blank'
  end

  test 'should not save comment when name and description is given but blog is not associated' do
    comment = Comment.new(name: 'Varun', description: 'Foobar')
    assert_not comment.save, 'Blog must exist'
  end

  test 'should save comment when all details are given' do
    blog = blogs(:music_sample)
    comment = Comment.new(name: 'Varun', description: 'Sample music description', blog: blog)
    assert comment.save
  end
end
