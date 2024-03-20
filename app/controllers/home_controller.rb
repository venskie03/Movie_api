require 'uri'
require 'net/http'
require_relative '../api/tmdbapi'
class HomeController < ApplicationController
API_KEY = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTU0NTY0MjA0ODkyMTQwYzY1OWNiOTY4MzlkYjg0YyIsInN1YiI6IjY1YWU5MzNlMjVjZDg1MDBhY2NiMWE4MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S9Jt-21GW3iaDr70K4caK37dhdjH7i5pDGa6d5Ez4vs'

def testing
end

def find_movie_bygenre
  movie_genre
  @genre_id = params[:id]
  @genre_name = params[:name]
  tmdb_api = Tmdbapi.new(API_KEY)
  @genre_data = tmdb_api.movie_bygenre(@genre_id, @genre_name)
end

def movie_overview
  movie_genre
  @movie_id = params[:id]
  movie_details_byid
  tmdb_api = Tmdbapi.new(API_KEY)
  @movie_data, @movie_key = tmdb_api.movieoverview(@movie_id)
end

def movie_details_byid
  @movie_id ||= params[:id]
  tmdb_api = Tmdbapi.new(API_KEY)
  @movie_details = tmdb_api.movie_details(@movie_id)
end

def movies_player
  tmdb_api = Tmdbapi.new(API_KEY)
  @url = tmdb_api.movie_player(@movie_url)
end


def fetch_data
  tmdb_api = Tmdbapi.new(API_KEY)
  @now_playing_movies = tmdb_api.now_playing_movies

  render json: @now_playing_movies
end


def now_playing
  tmdb_api = Tmdbapi.new(API_KEY)
  @now_playing_movies = tmdb_api.now_playing_movies

end

def popular
  tmdb_api = Tmdbapi.new(API_KEY)
  @popular_movies = tmdb_api.popular_movies
end

def toprated
  tmdb_api = Tmdbapi.new(API_KEY)
  @toprated_movies = tmdb_api.toprated_movie
end

def movie_genre
  movie_details_byid
  tmdb_api = Tmdbapi.new(API_KEY)
  @genre_list = tmdb_api.fetch_movie_genres
end

def home
  movie_genre
  popular
  now_playing
  toprated
end

  def top_movies
    movie_genre
    tmdb_api = Tmdbapi.new(API_KEY)
    @data = tmdb_api.top_movies
  end

  def find
    @alldata = []
    movie_genre
    @search_name = params[:search]&.gsub(' ', '%20')
    tmdb_api = Tmdbapi.new(API_KEY)
    @data = tmdb_api.search_byname(@search_name)
    @alldata.concat(@data[:data][:movies]) 
    @alldata.concat(@data[:data][:tv_shows])
  end
  

end
