require 'net/http'
require 'json'

class Tmdbapi
  BASE_URL = 'https://api.themoviedb.org/3'
  GENRE_ENDPOINT = '/genre/movie/list'

  def initialize(api_key)
    @api_key = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTU0NTY0MjA0ODkyMTQwYzY1OWNiOTY4MzlkYjg0YyIsInN1YiI6IjY1YWU5MzNlMjVjZDg1MDBhY2NiMWE4MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S9Jt-21GW3iaDr70K4caK37dhdjH7i5pDGa6d5Ez4vs"
  end

  def fetch_movie_genres
    uri = URI(BASE_URL + GENRE_ENDPOINT)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri)
    request['Accept'] = 'application/json'
    request['Authorization'] = "Bearer #{@api_key}"

    response = http.request(request)

    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.read_body)['genres']
    else
      nil
    end
  end

end
