import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const initMapbox = () => {
  const mapElement = document.querySelector("#map");
  console.log(mapElement.dataset)
  const markers = JSON.parse(mapElement.dataset.markers);


  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });

    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(map);
    });


    const fitMapToMarkers = (map, markers) => {
      const bounds = new mapboxgl.LngLatBounds();
      markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
      map.fitBounds(bounds, { padding: 50, maxZoom: 30, duration: 10000 });
    };

    fitMapToMarkers(map, markers);
  }
};


export { initMapbox };
