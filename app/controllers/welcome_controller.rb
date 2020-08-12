class WelcomeController < ApplicationController
    def index; end

    def random_number_trivia
        trivia = ::Services::GetTriviaInfo.new.get_random_number_trivia
        if trivia.success?
            render json: { trivia: trivia.body }
        else
            render json: { error: 'Data not available' }, status: 404 
        end
    end

    def random_date_trivia
        trivia = ::Services::GetTriviaInfo.new.get_random_date_trivia
        if trivia.success?
            render json: { trivia: trivia.body }
        else
            render json: { error: 'Data not available' }, status: 404 
        end
    end
end