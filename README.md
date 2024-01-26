# README
*MOVIE APP API WRAPPER
*Overview
The Movie App API Wrapper is a Ruby gem designed to simplify interactions with the Movie App API. It provides an easy-to-use interface for accessing movie data, including genres, titles, popularity, and more.

*Installation
To install the Movie App API Wrapper, add it to your Gemfile:

Then, run the following command to install the gem:
run: bundle install

To use the Movie App API Wrapper, follow these steps:
1. Add the net-http and uri libraries to your Ruby project.
2. Copy the HomeController class from the provided code into your project's controllers directory.

Usage
Configuration
Before using the wrapper, you need to configure it with your Movie App API credentials. You can do this in an initializer or directly in your code:

class SampleController < ApplicationController
request["Authorization"] = 'Your Bearer Key'
end

Replace 'Your Bearer Key' with your actual API key obtained from "https://www.themoviedb.org/settings/api".

Fetching Genres Url
"https://api.themoviedb.org/3/genre/movie/list?language=en"

Fetching Find Movie by Genre
https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=#{page_number}&sort_by=popularity.desc&with_genres=#{@genre_id}


* ...
