# frozen_string_literal: true

class MoviesController < ApplicationController
  def show
    @movie = MovieFacade.movie(params[:id])
    @reviews = MovieFacade.reviews(params[:id])
    @cast = MovieFacade.cast(params[:id])
  end

  def index
    @user = User.find(session[:user_id])
    if params[:top_rated]
      @top_rated = MovieFacade.top_rated
    elsif params[:title]
      @movies = SearchFacade.search(params[:title]).sort_by{|movie| -movie.vote_average}
    end
  end
end
