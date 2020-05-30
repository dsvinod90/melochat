class BlogsController < ApplicationController
    def index; end

    def show
        @blog = Blog.find(params[:id])
    end
end
