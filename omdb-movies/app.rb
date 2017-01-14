require 'bundler'
Bundler.require

require './lib/movie'
require './lib/omdb'

get '/' do
  erb :root
end

get '/movie' do
  @movie = OMDB.find(params[:movie_name])
  erb :show
end