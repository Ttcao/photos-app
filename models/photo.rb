class Photo < ActiveRecord::Base
  has_many :photo_labels
end
