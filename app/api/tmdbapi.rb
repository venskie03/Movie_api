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
