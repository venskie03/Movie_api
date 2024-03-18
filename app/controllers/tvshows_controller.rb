require 'uri'
require 'net/http'
require_relative '../api/tmdbapi'
class TvshowsController < ApplicationController
  API_KEY = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTU0NTY0MjA0ODkyMTQwYzY1OWNiOTY4MzlkYjg0YyIsInN1YiI6IjY1YWU5MzNlMjVjZDg1MDBhY2NiMWE4MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S9Jt-21GW3iaDr70K4caK37dhdjH7i5pDGa6d5Ez4vs'

  def pop_tvshows
    tmdb_api = Tmdbapi.new(API_KEY)
    @popular_tvshows = tmdb_api.tvshows
  end

  def tvshows_overview
    @tvshows_id = params[:id]
    tmdb_api = Tmdbapi.new(API_KEY)
    @tvshows_data = tmdb_api.tvshows_details(@tvshows_id)
    render json: @tvshows_data
  end


  def tvplayer
    ser_id = params[:series_id]
    s_num = params[:season_number]
    ep_num = params[:episode_number]
    @player = "https://vidsrc.xyz/embed/tv?tmdb=#{ser_id}&season=#{s_num}&episode=#{ep_num}"
    render plain: @player
  end

  def find_tvshows
    @tvshows_name = params[:search]&.gsub(' ', '%20')
    tmdb_api = Tmdbapi.new(API_KEY)
    @tvshows_data = tmdb_api.search_tvshows(@tvshows_name)
    render json: @tvshows_data
  end


  def home
    pop_tvshows
  end




end
