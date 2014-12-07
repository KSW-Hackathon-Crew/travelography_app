$( document ).ready(function() {

  $('#map-container').hide();

  $('#little-map').on('click', function(){
    console.log('clicked');
    $('#photo-grid').hide()
    $('#map-container').show();
  });

  $('#little-place').on('click', function(){
    $('#map-container').hide()
    $('#photo-grid').show();
  });

});
