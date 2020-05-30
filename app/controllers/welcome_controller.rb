class WelcomeController < ApplicationController
    def home
        @blog = Blog.last
    end
end
