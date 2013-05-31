$(document).ready(function() {

 
    $('[id^="carousel"]').carousel({
      interval: 5000
    });
     
    //$('#carousel-text').html($('#slide-content' + i + '-0').html());
     
    //Handles the carousel thumbnails
    $('[id^=carousel-selector-]').click( function(){
      var id_selector = $(this).attr("id");
      console.log(id_selector);
      var id = id_selector.substr(id_selector.length -1);
      console.log(id)
      var string = id_selector.substr(18, 8);
      console.log(string)
      var id = parseInt(id);
      $('#carousel_' + string).carousel(id-1);
    });
     
     
    // When the carousel slides, auto update the text
    //$(mycarousel).on('slid', function (e) {
     // var id = $('.item.active').data('slide-number');
      //$('#carousel-text').html($('#slide-content-'+id).html());
    //});
   
});
