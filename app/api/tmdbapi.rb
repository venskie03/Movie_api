require 'net/http'
require 'json'

class Tmdbapi
  BASE_URL = 'https://api.themoviedb.org/3'
  GENRE_ENDPOINT = '/genre/movie/list'
  NOW_PLAYING_ENDPOINT = '/movie/now_playing'
  MOVIE_PLAYER = "https://www.2embed.stream/embed/movie/"

  def initialize(api_key)
    @api_key = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTU0NTY0MjA0ODkyMTQwYzY1OWNiOTY4MzlkYjg0YyIsInN1YiI6IjY1YWU5MzNlMjVjZDg1MDBhY2NiMWE4MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S9Jt-21GW3iaDr70K4caK37dhdjH7i5pDGa6d5Ez4vs"
  end

  def movieoverview(movie_id)
    url = URI("https://api.themoviedb.org/3/movie/#{movie_id}/videos?language=en-US")
    response = send_request(url)
    movie_data = JSON.parse(response.read_body)
    movie_key = nil
    movie_data["results"].each do |trailer|
      if trailer["type"] == "Trailer"
        movie_key = trailer["key"]
        break
      end
    end
    return movie_data, movie_key
  end

  def popular_movies
    @popular_movie = []
    (1..3).each do |num|
      uri = URI("https://api.themoviedb.org/3/movie/popular?language=en-US&page=#{num}")
      response = send_request(uri)
      nowp_data = JSON.parse(response.read_body)
      @popular_movie.concat(nowp_data["results"])
    end
    @popular_movie
  end

  def toprated_movie
    @toprated_movie = []
    (1..3).each do |num|
      uri = URI("https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=#{num}")
      response = send_request(uri)
      nowp_data = JSON.parse(response.read_body)
      @toprated_movie.concat(nowp_data["results"])
    end
    @toprated_movie
  end

  def top_movies
    @data_movie = []
    (1..5).each do |num|
      uri = URI("https://api.themoviedb.org/3/movie/popular?language=en-US&page=#{num}")
      response = send_request(uri)
      movie_data = JSON.parse(response.read_body)
      @data_movie.concat(movie_data["results"])
    end
    @data_movie
  end

  def find_movies_byname(search_movie)
    if search_movie.present?
      @movie_data = []
     (1..5).each do |pagenum|
      uri = URI("https://api.themoviedb.org/3/search/movie?query=#{search_movie}&include_adult=false&language=en-US&page=#{pagenum}")
      response = send_request(uri)
      find_data = JSON.parse(response.body)
      @movie_data.concat(find_data["results"])
     end
     @movie_data
    else
      flash[:error] = "Search field cannot be empty"
    end
  end



  def movie_details(movie_id)
    uri = URI("https://api.themoviedb.org/3/movie/#{movie_id}?language=en-US")
    response_findbyid = send_request(uri)

    if response_findbyid.is_a?(Net::HTTPSuccess)
      JSON.parse(response_findbyid.read_body)
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
      @genre_details.concat(nowp_data["results"])
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
      @nowplaying_data.concat(nowp_data["results"])
    end
    @nowplaying_data
  end

  def tvshows_details(tvshows_id)
    uri =  URI("https://api.themoviedb.org/3/tv/#{tvshows_id}?language=en-US")
    response_findbyid = send_request(uri)
    if response_findbyid.is_a?(Net::HTTPSuccess)
      JSON.parse(response_findbyid.read_body)
    else
      nil
    end
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
