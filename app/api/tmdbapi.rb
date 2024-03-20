require 'net/http'
require 'json'

class Tmdbapi
  BASE_URL = 'https://api.themoviedb.org/3'
  GENRE_ENDPOINT = '/genre/movie/list'
  NOW_PLAYING_ENDPOINT = '/movie/now_playing'
  MOVIE_PLAYER = "https://www.2embed.stream/embed/movie/"
  FULLMOVIE_URL = "http://videoplayer.infinityfreeapp.com/se_player.php?video_id="
  BASE_API = "&tmdb=1"
  DP_URL= "https://image.tmdb.org/t/p/w500"

  MOVIE_URL1 = "https://vidsrc.to/embed/movie/"

  def initialize(api_key)
    @api_key = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTU0NTY0MjA0ODkyMTQwYzY1OWNiOTY4MzlkYjg0YyIsInN1YiI6IjY1YWU5MzNlMjVjZDg1MDBhY2NiMWE4MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S9Jt-21GW3iaDr70K4caK37dhdjH7i5pDGa6d5Ez4vs"
  end

  def popular_movies
  @popular_movies = []
  (1..3).each do |num|
    uri = URI("https://api.themoviedb.org/3/movie/popular?language=en-US&page=#{num}")
    response = send_request(uri)
    popular_movies_data = JSON.parse(response.read_body)
    popular_movies_data["results"].each do |movie|
      profile_picture_url = "#{DP_URL}#{movie["poster_path"]}"
      movie["profile_picture_url"] = profile_picture_url
      @popular_movies << movie
    end
  end
  @popular_movies
  end

  def toprated_movie
    @toprated_movie = []
    (1..3).each do |num|
      uri = URI("https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=#{num}")
      response = send_request(uri)
      toprated_movie_data = JSON.parse(response.read_body)
      toprated_movie_data["results"].each do |movie|
        profile_picture_url = "#{DP_URL}#{movie["poster_path"]}"
        movie["profile_picture_url"] = profile_picture_url
        @toprated_movie << movie
      end
    end
    @toprated_movie
  end

  def top_movies
    @data_movie = []
    (1..5).each do |num|
      uri = URI("https://api.themoviedb.org/3/movie/popular?language=en-US&page=#{num}")
      response = send_request(uri)
      movie_data = JSON.parse(response.read_body)
      movie_data["results"].each do |movie|
        profile_picture_url = "#{DP_URL}#{movie["poster_path"]}"
        movie["profile_picture_url"] = profile_picture_url
        @data_movie << movie
      end
    end
    @data_movie
  end


  def movie_details(movie_id)
    uri = URI("https://api.themoviedb.org/3/movie/#{movie_id}?language=en-US")
    response_findbyid = send_request(uri)

    if response_findbyid.is_a?(Net::HTTPSuccess)
      movie_details = JSON.parse(response_findbyid.read_body)
      if movie_details.present?
        profile_picture_url = "#{DP_URL}#{movie_details["poster_path"]}"
        full_movie_url = "#{FULLMOVIE_URL}#{movie_id}#{BASE_API}"
        full_movie_url_1 = "#{MOVIE_URL1}#{movie_id}"
        movie_details["fullmovieurl"] = full_movie_url
        movie_details["fullmovieurl_1"] = full_movie_url_1
        movie_details["profile_pictureURL"] = profile_picture_url
      end
      movie_details
    else
      nil
    end
  end

  def movie_player(movie_url)
    movie_url = MOVIE_PLAYER
  end

  def movie_bygenre(genre_id, genre_name)
    @genre_details = []
    (1..3).each do |num|
      uri = URI("https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=#{num}&sort_by=popularity.desc&with_genres=#{genre_id}")
      response = send_request(uri)
      nowp_data = JSON.parse(response.read_body)
      nowp_data["results"].each do |movie|
        profile_picture_url = "#{DP_URL}#{movie["poster_path"]}"
        movie["profile_picture_url"] = profile_picture_url
        @genre_details << movie
      end
    end
    @genre_details
  end

  def fetch_movie_genres
    uri = URI(BASE_URL + GENRE_ENDPOINT)
    response = send_request(uri)

    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)['genres']
    else
      nil
    end
  end

  def now_playing_movies
    @nowplaying_data = []
    (1..20).each do |num|
      uri = URI(BASE_URL + NOW_PLAYING_ENDPOINT + "?language=en-US&page=#{num}")
      response = send_request(uri)
      nowp_data = JSON.parse(response.body)
     nowp_data["results"].each do |movie|
      profile_picture_url = "#{DP_URL}#{movie["poster_path"]}"
      movie["profile_picture_url"] = profile_picture_url
      @nowplaying_data << movie
     end
    end
    @nowplaying_data
  end


  ############# TV SHOWS ###############

  def tvshows_details(tvshows_id)
    uri = URI("https://api.themoviedb.org/3/tv/#{tvshows_id}?language=en-US")
    response_findbyid = send_request(uri)
    if response_findbyid.is_a?(Net::HTTPSuccess)
      @tvshow_data = JSON.parse(response_findbyid.read_body)
      if @tvshow_data.present?
        tvshows_data = {
          poster_path: "https://image.tmdb.org/t/p/w500#{@tvshow_data["poster_path"]}",
          original_name: @tvshow_data["original_name"],
          overview: @tvshow_data["overview"],
          Genres:  @tvshow_data["genres"].map { |genre| genre["name"] },
          number_of_seasons: @tvshow_data["number_of_seasons"],
          seasons: @tvshow_data["seasons"].reject { |season| season["season_number"] == 0 }.map do |season|
            {
              season_number: season["season_number"],
              name: season["name"],
              episodes: (1..season["episode_count"].to_i).map do |number|
                {
                  episode: number,
                  tvplayer_url: "http://videoplayer.infinityfreeapp.com/se_player.php?video_id=#{@tvshow_data["id"]}&tmdb=1&s=#{season["season_number"]}&e=#{number}"
                }
              end
            }
          end
        }
        tvshows_data
      end
    else
      nil
    end
  end


  def tvshows
    @tvshows = []
    (1..3).each do |num|
      uri = URI("https://api.themoviedb.org/3/tv/top_rated?language=en-US&page=#{num}")
      response = send_request(uri)
      nowp_data = JSON.parse(response.read_body)
      nowp_data["results"].each do |tvshow|
        profile_picture_url = "#{DP_URL}#{tvshow["poster_path"]}"
        tvshow["profile_picture_url"] = profile_picture_url
        @tvshows << tvshow
      end
    end
    @tvshows
  end

  def find_movies_byname(search_name)
    if search_name.present?
      @movie_data = []
     (1..5).each do |pagenum|
      uri = URI("https://api.themoviedb.org/3/search/movie?query=#{search_name}&include_adult=false&language=en-US&page=#{pagenum}")
      response = send_request(uri)
      find_data = JSON.parse(response.body)
      find_data["results"].each do |movie|
        profile_picture_url = "#{DP_URL}#{movie["poster_path"]}"
        movie["profile_picture_url"] = profile_picture_url
        movie["series_type"] = "Movie"
        @movie_data << movie
      end
     end
     @movie_data
    else
      flash[:error] = "Search field cannot be empty"
    end
  end

  def search_tvshows(search_name)
    @search_tvshows = []
    (1..20).each do |num|
    uri = URI("https://api.themoviedb.org/3/search/tv?query=#{search_name}&include_adult=false&language=en-US&page=#{num}")
    response = send_request(uri)
    tvdata = JSON.parse(response.read_body)
    tvdata["results"].each do |tv|
      profile_picture_url = "#{DP_URL}#{tv["poster_path"]}"
      tv["profile_picture_url"] = profile_picture_url
      tv["series_type"] = "TVShows"
      @search_tvshows << tv
    end
    end
    @search_tvshows
  end

  def search_byname(search_name)
    find_movies_byname(search_name)
    search_tvshows(search_name)

    {
      data: {
        movies: @movie_data,
        tv_shows: @search_tvshows
      }
    }
  end


  private

  def send_request(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri)
    request['Accept'] = 'application/json'
    request['Authorization'] = "Bearer #{@api_key}"

    http.request(request)
  end
end