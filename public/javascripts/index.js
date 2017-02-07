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

        var imageBoard = document.getElementById('image-board');

        var image = new Image();
        image.src = "data:image/png;base64," + imageObject.image ;
        image.classList.add('img-responsive');

        var div = document.createElement("div");
        div.classList.add('col-lg-3', 'col-md-4', 'col-xs-6', 'thumb');

        div.appendChild(image);

        imageBoard.append(div);

      });

    });

  };

  $('#selected-labels').on('click', showSelectedImages);

});
