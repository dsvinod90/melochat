# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_blog_post

  def index
    @comments = @blog_post.comments
  end

  def create
    build_comment = @blog_post.comments.build(
      name: params[:name],
      email: params[:email],
      description: params[:description]
    )
    if build_comment.save
      flash[:notice] = 'Comment added successfully!'
    else
      flash[:danger] = build_comment.errors.full_messages.to_sentence
    end
    redirect_to(blog_path(@blog_post))
  end

  private

  def find_blog_post
    @blog_post = Blog.find_by(id: params[:blog_id])
  end
end
