require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, 'sqlite3:db/pizza.db'

# Models creating
#--------------------------------

class Product < ActiveRecord::Base
end

#login / logout
#--------------------------------

configure do
  enable :sessions
end

helpers do
  def username
    session[:identity] ? session[:identity] : 'Sign in'
  end
end

before '/secure/*' do
  unless session[:identity]
    session[:previous_url] = request.path
    @error = 'Need to be logged ' + request.path
    halt erb(:login_form)
  end
end

get '/login/form' do
  erb :login_form
end

post '/login/attempt' do
  session[:identity] = params['username']
  where_user_came_from = session[:previous_url] || '/'
  redirect to where_user_came_from
end

get '/logout' do
  session.delete(:identity)
  redirect to :index
end

# Secret place
#-----------------------------

get '/secure/place' do


  erb :secret
end

#root page
#-----------------------------

get '/' do
  @products = Product.all

  erb :index
end

# About
# ----------------------------

get '/about' do


  erb :about
end
