$(document).ready(function() {

  // search for labels
  $(".multiple-searchbar").select2({
    placeholder: "Select a category"
  });

  var showSelectedImages = function() {

    var selectedValues = $('.multiple-searchbar').val()

    // send selectedVaues and retrieve the id
    $.ajax({
      method: 'POST',
      url: "/photos",
      data: JSON.stringify({label: selectedValues}),
    }).done(function(response) {

      var imageBoard = document.getElementById('image-board');

      // clear imageBoard before appending images
      clearImageBoard(imageBoard);

      response.images.forEach(function(imageObject) {

        var image = new Image();
        image.src = "data:image/png;base64," + imageObject.image;
        image.classList.add('img-responsive');

        var imageDiv = document.createElement("div");
        imageDiv.classList.add('col-lg-3', 'col-md-4', 'col-xs-6', 'thumb');

        var aElement = document.createElement("a");
        aElement.setAttribute('href', "data:image/png;base64," + imageObject.image);
        aElement.classList.add('fancybox');

        var documentFragment = document.createDocumentFragment();
        documentFragment.appendChild(aElement);
        aElement.appendChild(image);
        imageDiv.appendChild(documentFragment);

        imageBoard.append(imageDiv);

      });

      $('.fancybox').fancybox({
       padding : 0,
       type        : 'image',
       openEffect  : 'none',
       closeEffect : 'none'
      });

    });

  };

  // clear the images on the page
  var clearImageBoard = function(board) {
     board.innerHTML = "";
    };

  $('#selected-labels').on('click', showSelectedImages);


});
