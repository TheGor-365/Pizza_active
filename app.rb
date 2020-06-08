require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, 'sqlite3:db/pizza.db'

# Models creating
#--------------------------------

class Product < ActiveRecord::Base
end

class Order <ActiveRecord::Base
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

# Order data split method (for cart)
#-----------------------------

def parse_orders_input orders_input
	s1 = orders_input.split(/\,/)
	arr = []

	s1.each do |x|
		s2 = x.split(/\=/)
		s3 = s2[0].split(/\_/)

		id = s3[1]
		cnt = s2[1]

		arr2 = [id, cnt]

		arr.push arr2
	end
	return arr
end

# cart page
#-----------------------------

post '/cart' do
  @orders_input = params[:orderstring]
  @items = parse_orders_input @orders_input

  if @items.length == 0
    return erb :cart_is_empty
  end

  @items.each do |item|
    item[0] = Product.find(item[0])
  end

  erb :cart
end

get '/cart' do


  erb :cart
end

# place_order page
#------------------------------

post '/place_order' do
  @orders = Order.create params[:orders]

  erb :order_placed
end
