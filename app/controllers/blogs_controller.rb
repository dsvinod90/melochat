class BlogsController < ApplicationController
    def index 
        @blogs = Blog.where(category: blog_params[:type])
        @type = blog_params[:type]
    end

    def show
        @blog = Blog.find_by(id: blog_params[:id])
        unless @blog
            redirect_to welcome_home_path, flash: { danger: I18n.t('blogs.article_not_found') }
        end
    end

    def new
        @blog = Blog.new
    end

    def create
        blog = Blog.new(create_blog_params)
        if blog.save!
            redirect_to blog_path(blog.id), flash: { success: 'Article created successfully' }
        else
            render 'new'
            flash.now('Not created')
        end
    end

    def edit
        @blog = Blog.find(blog_params[:id])
    end

    def update
        @blog = Blog.find(blog_params[:id])
        if @blog.update(create_blog_params)
            redirect_to @blog
        else
            render 'edit'
        end
    end

    private

    def blog_params
        params.permit(:id, :type)
    end

    def create_blog_params
        params.require(:blog).permit(:title, :author, :description, :body, :category)
    end
end
