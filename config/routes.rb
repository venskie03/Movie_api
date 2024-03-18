Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#home"
  get '/movies', to: "home#find", as: "find_movies"
  get '/topmovies', to: "home#top_movies", as: "top_movies"
  get '/movie_overview/:id', to: "home#movie_overview", as: "movie_overview"
  get '/movie/:name/:id', to: "home#find_movie_bygenre", as: "find_genre"
  get '/fetch_data', to: "home#fetch_data", as: "fetch_data"
  get '/play_movies', to: "home#movies_player", as: "movies_player"
  get 'embed/movie/:id', to: 'movies#show', as: 'embed_movie'

  get '/tvshows', to: "tvshows#home"
  get '/tvshows_overview/:id', to: "tvshows#tvshows_overview", as: "tvshows_overview"
  get '/tvshows_player/:series_id/:season_number/:episode_number', to: "tvshows#tvplayer", as: "tvplayer"
  get '/find_tvshows/:search', to: "tvshows#find_tvshows", as: "find_tvshows"

  #### RENDER TO JSON
  namespace :api do
    namespace :v1 do
      ## fetch nowplaying movies
      get '/nowplayingmovies', to: "api#nowplayingmovies"

      get '/genre/:id', to: "api#find_movie_bygenre"

      get '/genre_list', to: "api#movie_genre"

      get '/popular', to: "api#popular"

      get '/details/:id', to: "api#movie_details_byid"

      get '/toprated_movies', to: "api#toprated"

      get '/movie_name/:search', to: "api#find"
    end
  end

  namespace :api do
    namespace :v2 do
      get '/tvshows_overview/:id', to: "tvshows_api_#tvshows_overview"
      get '/find_tvshows/:search', to: "tvshows_api_#find_tvshows"
      get '/tvshows', to: "tvshows_api_#home"
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  # Defines the root path route ("/")
  # root "posts#index"
end
