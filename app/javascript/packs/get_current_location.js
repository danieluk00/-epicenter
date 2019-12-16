const autocompleteAddress = () => {
  const locationWrapper = document.querySelector('.ap-input-icon')
  if (locationWrapper) {
    const icon = document.querySelector('.ap-input-icon.ap-icon-pin')
    icon.addEventListener("click", (event) => {
      console.log(event);
      console.log(event.currentTarget);

      navigator.geolocation.getCurrentPosition((position) => {
        const lat = position.coords.latitude;
        const lng = position.coords.longitude;
        const url = `https://api.mapbox.com/geocoding/v5/mapbox.places/${lng},${lat}.json?access_token=pk.eyJ1IjoibWlhbm1hcnUiLCJhIjoiY2szMDl2MnZsMDMzNDNtbm45eGt4eXZociJ9.YnUj-3tl7H3JgmMzmQWU3w`
        fetch(url)
          .then(response => response.json())
          .then((data) => {
            const currentAddress = data.features[0].place_name
            const addressField = document.getElementById("event_user_address");
            addressField.value = currentAddress;
        });

      });
    });
  }
}

export { autocompleteAddress };
