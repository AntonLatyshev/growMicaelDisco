import STYLES from './styles';
const map = () => {
  if ($('#map').length) {
    var searchMap = function() {
      var map = $('#map');
      var markerPosition = new google.maps.LatLng(50.4403142, 30.4896234);
      var centerPosition = new google.maps.LatLng(50.4403142, 30.4896234);
      var infowindow = new google.maps.InfoWindow({
        content: data
      });
      var mapOptions = {
        zoom: 13,
        center: centerPosition,
        scrollwheel: false,
        navigationControl: false,
        mapTypeControl: false,
        scaleControl: false,
        draggable: true,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        styles: STYLES
      };
      var map = new google.maps.Map(document.getElementById("map"), mapOptions);
      const marker = new google.maps.Marker({
        map: map,
        draggable: true,
        animation: google.maps.Animation.DROP,
        position: {
          lat: 50.4403142,
          lng: 30.4896234
        },
        icon: {
          url: '/catalog/view/theme/default/image/marker.png',
          scaledSize: new google.maps.Size(156, 129)
        }
      });

      marker.addListener('mouseover', toggleBounce);
      google.maps.event.addListener(marker, 'click', function() {
        marker.setAnimation(null);
        infowindow.setContent($('.contact address').text());
        infowindow.open(map, marker);
      });

      function toggleBounce() {
        marker.setAnimation(google.maps.Animation.BOUNCE);
        setTimeout(function() {
          marker.setAnimation(null);
        }, 4000)
      }
      var data = '';
      marker.setMap(map);
    }
    searchMap();
  }
}
export default map;
