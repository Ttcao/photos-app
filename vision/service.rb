class Service

  def photo_to_photolabels

    # Your Google Cloud Platform project ID
    project_id = "studious-nature-157713"

    # Instantiates a client
    vision = Google::Cloud::Vision.new project: project_id

    # Performs label detection on the image file
    puts "message: #{@photo[:image][:tempfile]}"
    labels = vision.image(@photo[:image][:tempfile]).labels

    puts "Labels:"
    labels.each do |label|
      puts label.description
    end

    labels.to_json

  end


end
