$(document).ready(function() {

  // search for labels
  $(".multiple-searchbar").select2({
    placeholder: "Select a category"
  });

  //
  var showSelectedImages = function() {

    var selectedValues = $('.multiple-searchbar').val()

    // send selectedVaues and retrieve the id
    $.ajax({
      method: 'POST',
      url: "/photos",
      data: JSON.stringify({label: selectedValues}),
    }).done(function(response) {
      response.images.forEach(function(imageObject) {
        var image = new Image();
        image.src = "data:image/png;base64," + imageObject.image ;
        var imageBoard = document.getElementById('image-board');
        imageBoard.appendChild(image);
      });

    });

  };

  $('#selected-labels').on('click', showSelectedImages);

});
