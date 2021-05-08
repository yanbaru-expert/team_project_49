class MoviesController < ApplicationController

  def index
    @movies = Movie.where(genre: ["basic", "git", "ruby", "rails"]).order(id: :asc)
  end

end
