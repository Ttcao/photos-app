require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'active_record'
require 'sinatra/activerecord'
require 'json'
require 'google/cloud/vision'
require_relative 'models/photo'
require_relative 'models/photo_label'
require_relative 'service/vision_service'

get '/' do
  erb :index
  # content_type :json
  # { :message => 'hello world' }.to_json
end

post '/photo' do
  tempfile = @params[:image][:tempfile]
  image = Base64.encode64(open(tempfile) { |io| io.read })
  @photo = Photo.new({image: image.gsub(/\n/, '')})
  @photo.save
  vision_service = VisionService.new
  @photo_labels = vision_service.tempfile_to_photo_labels(tempfile, @photo.id)
  binding.pry
  @photo_labels.each {|label| label.save}
  @photo_labels.to_json
end
