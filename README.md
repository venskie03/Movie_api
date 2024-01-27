# README
# MOVIE APP API WRAPPER
# Overview
The Movie App API Wrapper is a Ruby gem designed to simplify interactions with the Movie App API. It provides an easy-to-use interface for accessing movie data, including genres, titles, popularity, and more.

# Installation
To install the Movie App API Wrapper, add it to your Gemfile:

Then, run the following command to install the gem:
run: bundle install

To use the Movie App API Wrapper, follow these steps:
1. Add the net-http and uri libraries to your Ruby project.
2. Copy the HomeController class from the provided code into your project's controllers directory.

# Usage Configuration
Before using the wrapper, you need to configure it with your Movie App API credentials. You can do this in an initializer or directly in your code:

class SampleController < ApplicationController
request["Authorization"] = 'Your Bearer Key'
end

Replace 'Your Bearer Key' with your actual API key obtained from "https://www.themoviedb.org/settings/api".

# Additional Features
* Movie Details
You can retrieve details for a specific movie by its ID using the following URL format:

https://api.themoviedb.org/3/movie/<movie_id>?language=en-US

Replace <movie_id> with the ID of the movie you want to retrieve details for.

* Movie Videos
To fetch videos (e.g., trailers) associated with a movie, you can use the following URL format:

https://api.themoviedb.org/3/movie/<movie_id>/videos?language=en-US

Replace <movie_id> with the ID of the movie you want to fetch videos for.

* Now Playing Movies
To retrieve a list of currently playing movies, you can use the following URL format:

https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=<page_number>

Replace <page_number> with the page number to paginate through the list of now playing movies.

* Top Rated Movies
To fetch a list of top-rated movies, you can use the following URL format:

https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=<page_number>

Replace <page_number> with the page number to paginate through the list of top-rated movies.

* Popular Movies
You can retrieve a list of popular movies using the following URL format:

https://api.themoviedb.org/3/movie/popular?language=en-US&page=<page_number>

Replace <page_number> with the page number to paginate through the list of popular movies.

* TV Shows
To fetch a list of TV shows, you can use the following URL format:

https://api.themoviedb.org/3/discover/tv?include_adult=false&include_null_first_air_dates=false&language=en-US&page=<page_number>&sort_by=popularity.desc

Replace <page_number> with the page number to paginate through the list of TV shows.

* Search Movies
You can search for movies using the following URL format:

https://api.themoviedb.org/3/search/movie?query=<search_query>&include_adult=false&language=en-US&page=<page_number>

Replace <search_query> with your search query and <page_number> with the page number to paginate through the search results.
* ...
