require_relative '../../../api/tmdbapi'
class Api::V1::ApiController < ApplicationController
  API_KEY = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTU0NTY0MjA0ODkyMTQwYzY1OWNiOTY4MzlkYjg0YyIsInN1YiI6IjY1YWU5MzNlMjVjZDg1MDBhY2NiMWE4MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S9Jt-21GW3iaDr70K4caK37dhdjH7i5pDGa6d5Ez4vs'

  def nowplayingmovies
  tmdb_api = Tmdbapi.new(API_KEY)
  @now_playing_movies = tmdb_api.now_playing_movies
  render json: @now_playing_movies
  end

  def find_movie_bygenre
    @genre_id = params[:id]
    tmdb_api = Tmdbapi.new(API_KEY)
    @genre_data = tmdb_api.movie_bygenre(@genre_id, @genre_name)
    render json: @genre_data
  end

  def movie_genre
    tmdb_api = Tmdbapi.new(API_KEY)
    @genre_list = tmdb_api.fetch_movie_genres
    render json: @genre_list
  end

  def popular
    tmdb_api = Tmdbapi.new(API_KEY)
    @popular_movies = tmdb_api.popular_movies
    render json: @popular_movies
  end

  def movie_details_byid
    @movie_id ||= params[:id]
    tmdb_api = Tmdbapi.new(API_KEY)
    @movie_details = tmdb_api.movie_details(@movie_id)
    render json: @movie_details
  end

  def toprated
    tmdb_api = Tmdbapi.new(API_KEY)
    @toprated_movies = tmdb_api.toprated_movie
    render json: @toprated_movies
  end

end
