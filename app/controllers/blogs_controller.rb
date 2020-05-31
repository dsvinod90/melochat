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

    private

    def blog_params
        params.permit(:id, :type)
    end
end
