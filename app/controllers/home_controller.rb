require 'uri'
require 'net/http'
class HomeController < ApplicationController

def movie_genre
genre_url = URI("https://api.themoviedb.org/3/genre/movie/list?language=en")

http = Net::HTTP.new(genre_url.host, genre_url.port)
http.use_ssl = true

request_genre = Net::HTTP::Get.new(genre_url)
request_genre["accept"] = 'application/json'
request_genre["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTU0NTY0MjA0ODkyMTQwYzY1OWNiOTY4MzlkYjg0YyIsInN1YiI6IjY1YWU5MzNlMjVjZDg1MDBhY2NiMWE4MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S9Jt-21GW3iaDr70K4caK37dhdjH7i5pDGa6d5Ez4vs'

genre_response = http.request(request_genre)
@genre_list = JSON.parse(genre_response.read_body)
end

def find_movie_bygenre
  movie_genre
  @genre_id = params[:id]
  @genre_name = params[:name]
  @genre_data = []
  (1..3).each do |num|
    url = URI("https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=#{num}&sort_by=popularity.desc&with_genres=#{@genre_id}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTU0NTY0MjA0ODkyMTQwYzY1OWNiOTY4MzlkYjg0YyIsInN1YiI6IjY1YWU5MzNlMjVjZDg1MDBhY2NiMWE4MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S9Jt-21GW3iaDr70K4caK37dhdjH7i5pDGa6d5Ez4vs'
    response = http.request(request)
    nowp_data = JSON.parse(response.read_body)
    @genre_data.concat(nowp_data["results"])
  end
end

def movie_overview
movie_genre
@movie_id = params[:id]
url = URI("https://api.themoviedb.org/3/movie/#{@movie_id}/videos?language=en-US")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTU0NTY0MjA0ODkyMTQwYzY1OWNiOTY4MzlkYjg0YyIsInN1YiI6IjY1YWU5MzNlMjVjZDg1MDBhY2NiMWE4MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S9Jt-21GW3iaDr70K4caK37dhdjH7i5pDGa6d5Ez4vs'

response = http.request(request)
@movie_data = JSON.parse(response.read_body)
@movie_data["results"].each do |trailer|
  if trailer["type"] == "Trailer"
    @movie_key = trailer["key"]
  end
end

findbyid_url = URI("https://api.themoviedb.org/3/movie/#{@movie_id}?language=en-US")

  http = Net::HTTP.new(findbyid_url.host, findbyid_url.port)
  http.use_ssl = true

  findbyid = Net::HTTP::Get.new(findbyid_url)
  findbyid["accept"] = 'application/json'
  findbyid["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTU0NTY0MjA0ODkyMTQwYzY1OWNiOTY4MzlkYjg0YyIsInN1YiI6IjY1YWU5MzNlMjVjZDg1MDBhY2NiMWE4MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S9Jt-21GW3iaDr70K4caK37dhdjH7i5pDGa6d5Ez4vs'

  response_findbyid = http.request(findbyid)
  @movie_details = JSON.parse(response_findbyid.read_body)

end



def now_playing
  @nowplaying_data = []
  (1..3).each do |num|
    url = URI("https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=#{num}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTU0NTY0MjA0ODkyMTQwYzY1OWNiOTY4MzlkYjg0YyIsInN1YiI6IjY1YWU5MzNlMjVjZDg1MDBhY2NiMWE4MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S9Jt-21GW3iaDr70K4caK37dhdjH7i5pDGa6d5Ez4vs'
    response = http.request(request)
    nowp_data = JSON.parse(response.read_body)
    @nowplaying_data.concat(nowp_data["results"])
  end
end

def popular
  @popular_movies = []
  (1..3).each do |num|
    url = URI("https://api.themoviedb.org/3/movie/popular?language=en-US&page=#{num}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTU0NTY0MjA0ODkyMTQwYzY1OWNiOTY4MzlkYjg0YyIsInN1YiI6IjY1YWU5MzNlMjVjZDg1MDBhY2NiMWE4MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S9Jt-21GW3iaDr70K4caK37dhdjH7i5pDGa6d5Ez4vs'
    response = http.request(request)
    nowp_data = JSON.parse(response.read_body)
    @popular_movies.concat(nowp_data["results"])
  end
end

def toprated
  @toprated_movies = []
  (1..3).each do |num|
    url = URI("https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=#{num}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTU0NTY0MjA0ODkyMTQwYzY1OWNiOTY4MzlkYjg0YyIsInN1YiI6IjY1YWU5MzNlMjVjZDg1MDBhY2NiMWE4MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S9Jt-21GW3iaDr70K4caK37dhdjH7i5pDGa6d5Ez4vs'
    response = http.request(request)
    nowp_data = JSON.parse(response.read_body)
    @toprated_movies.concat(nowp_data["results"])
  end
end

def tvshows
  @tvshows = []
  (1..3).each do |num|
    url = URI("https://api.themoviedb.org/3/discover/tv?include_adult=false&include_null_first_air_dates=false&language=en-US&page=#{num}&sort_by=popularity.desc")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTU0NTY0MjA0ODkyMTQwYzY1OWNiOTY4MzlkYjg0YyIsInN1YiI6IjY1YWU5MzNlMjVjZDg1MDBhY2NiMWE4MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S9Jt-21GW3iaDr70K4caK37dhdjH7i5pDGa6d5Ez4vs'
    response = http.request(request)
    nowp_data = JSON.parse(response.read_body)
    @tvshows.concat(nowp_data["results"])
  end
end

def home
  movie_genre
  tvshows
  popular
  now_playing
  toprated
end

  def top_movies
    movie_genre
    @data = []
    (1..5).each do |num|
      url = URI("https://api.themoviedb.org/3/movie/popular?language=en-US&page=#{num}")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(url)
      request["accept"] = 'application/json'
      request["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTU0NTY0MjA0ODkyMTQwYzY1OWNiOTY4MzlkYjg0YyIsInN1YiI6IjY1YWU5MzNlMjVjZDg1MDBhY2NiMWE4MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S9Jt-21GW3iaDr70K4caK37dhdjH7i5pDGa6d5Ez4vs'
      response = http.request(request)
      movie_data = JSON.parse(response.read_body)
      @data.concat(movie_data["results"])
    end
  end

  def find
    movie_genre
    @search_movie = params[:search]&.gsub(' ', '%20')
    if @search_movie.present?
      @data = []
     (1..5).each do |pagenum|
      url = URI("https://api.themoviedb.org/3/search/movie?query=#{@search_movie}&include_adult=false&language=en-US&page=#{pagenum}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["accept"] = 'application/json'
      request["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTU0NTY0MjA0ODkyMTQwYzY1OWNiOTY4MzlkYjg0YyIsInN1YiI6IjY1YWU5MzNlMjVjZDg1MDBhY2NiMWE4MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S9Jt-21GW3iaDr70K4caK37dhdjH7i5pDGa6d5Ez4vs'

      response = http.request(request)
      find_data = JSON.parse(response.body)
      @data.concat(find_data["results"])
     end
    else
      flash[:error] = "Search field cannot be empty"
    end
  end
end
