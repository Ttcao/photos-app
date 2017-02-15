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
  @photolabels = PhotoLabel.all
  erb :index
  # content_type :json
end

post '/photo' do
  tempfile = @params[:image][:tempfile]
  opened_file = File.open(tempfile, "r")
  read_file = opened_file.read
  image = Base64.encode64(read_file)
  @photo = Photo.new({image: image.gsub(/\n/, '')})
  @photo.save
  vision_service = VisionService.new
  @photo_labels = vision_service.tempfile_to_photo_labels(tempfile, @photo.id)
  @photo_labels.each {|label| label.save}
  @photo_labels.to_json
  redirect to '/'
end

post '/photos' do
  @json = JSON.parse(request.body.read)

  # get photo label values from json array
  @photo_label = PhotoLabel.where(@json)

  # get the base64 string
  @matching_photos = @photo_label.map do |label|
    @matching_photo_id = label.photo_id
    @photos = Photo.where(id: @matching_photo_id)
    @photos.map do |photo|
      {"image": photo.image}
    end
  end

  # send back to client as a json array
  content_type :json
  {"images": @matching_photos.flatten}.to_json
end
