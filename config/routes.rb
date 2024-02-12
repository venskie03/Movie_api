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

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  # Defines the root path route ("/")
  # root "posts#index"
end