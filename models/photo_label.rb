class PhotoLabel < ActiveRecord::Base
  belongs_to :photo
end

# def google_label_to_photo_label(google_label, photo_id)
#   score = google_label.score
#   label = google_label.description
#   photo_label = PhotoLabel.new({:label=>label, :score=>score, :photo_id=>photo_id})
#   return photo_label
# end
