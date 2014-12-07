  var mapOptions = {center: { lat: -34.397, lng: 150.644}, zoom: 8};
  var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

function initialize() {
  var info = createInfoWindow("Congratulations!");
  google.maps.event.addListener(marker, 'click', function() {
    info.open(map,marker);
  });
}
  var myLatLong = new google.maps.LatLng(-34.397,150.644);
  google.maps.event.addDomListener(window, 'load', initialize);
  createMarker(myLatLong, map, "Test");

var marker;
function createMarker(coords, map, title){
  marker = new google.maps.Marker({
    position: coords,
    map: map,
    title: title,
  });
}

function createImage(url){
  var image = {
    url: url,
    // This marker is 32 pixels wide by 32 pixels tall.
    size: new google.maps.Size(32, 32),
    // The origin for this image is 0,0.
    origin: new google.maps.Point(0,0),
    // The anchor for this image is the base of the flagpole at 0,32.
    anchor: new google.maps.Point(0, 32)
  };
  return image;
}

function createCustomMarker(coords,map,title){
  marker = new google.maps.Marker({
    position: coords,
    map: map,
    title: title,
    icon: createImage("/assets/icon.png")
  });
}

function createInfoWindow(text){
  var infowindow = new google.maps.InfoWindow({
    content: text
  });
  return infowindow;
}
