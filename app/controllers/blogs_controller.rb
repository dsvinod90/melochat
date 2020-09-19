# frozen_string_literal: true

class BlogsController < ApplicationController
  before_action :authenticate_admin!, except: %i[index show]

  def index
    @blogs = Blog.where(category: blog_params[:type])
    @type = blog_params[:type]
  end

  def show
    @blog = Blog.find_by(id: blog_params[:id])
    redirect_to(welcome_index_path, flash: { danger: I18n.t('blogs.article_not_found') }) unless @blog
  end

  def new
    @blog = Blog.new
  end

  def create
    params[:blog][:author] = current_admin.name
    blog = Blog.new(create_blog_params.except(:cover_photo))
    if blog.save
      blog.cover_photo.attach(create_blog_params[:cover_photo])
      redirect_to(blog_path(blog.id), flash: { success: 'Article created successfully' })
    else
      flash.now[:danger] = blog.errors.full_messages.to_sentence
      render(:new)
    end
  end

  def edit
    @blog = Blog.find(blog_params[:id])
  end

  def update
    @blog = Blog.find(blog_params[:id])
    if @blog.update(create_blog_params)
      redirect_to(@blog)
    else
      flash.now[:danger] = blog.errors.full_messages.to_sentence
      render(:edit)
    end
  end

  def destroy
    @blog = Blog.find(blog_params[:id])
    blog_type = @blog.category
    if @blog.delete
      redirect_to(blogs_path(type: blog_type), flash: { success: 'Article deleted successfully' })
    else
      flash.now[:danger] = 'Article could not be deleted'
      render(:index)
    end
  end

  private

  def blog_params
    params.permit(:id, :type)
  end

  def create_blog_params
    params.require(:blog).permit(:title, :author, :description, :body, :category, :cover_photo)
  end
end
