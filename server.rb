require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'active_record'
require 'sinatra/activerecord'
require 'json'
require 'google/cloud/vision'
require_relative 'models/photo'

get '/' do
  erb :index
  # content_type :json
  # { :message => 'hello world' }.to_json
end

post '/photo' do
  @photo = Photo.new(@params)
  
end
