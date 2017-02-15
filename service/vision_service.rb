require 'google/cloud/vision'
require 'pry'
require_relative '../models/photo'
require_relative '../models/photo_label'

class VisionService

  def tempfile_to_photo_labels(tempfile, photo_id)

    project_id = "studious-nature-157713"

    # Instantiates a client
    vision = Google::Cloud::Vision.new project: project_id

    # Performs label detection on the image file
    google_labels = vision.image(tempfile).labels

    # convert each label to our photo_label
    results = google_labels.map { |google_label| google_label_to_photo_label(google_label, photo_id) }
    all_label = PhotoLabel.new({:label=>"all", :score=>100, :photo_id=>photo_id})
    results << all_label
    return results

  end

  def google_label_to_photo_label(google_label, photo_id)
    score = google_label.score
    label = google_label.description
    photo_label = PhotoLabel.new({:label=>label, :score=>score, :photo_id=>photo_id})
    return photo_label
  end

end
