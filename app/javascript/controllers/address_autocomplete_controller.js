// app/javascript/controllers/address_autocomplete_controller.js
import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { apiKey: String }
  static targets = ["address"]


  connect() {
    // console.log("connected")

    this.element.querySelectorAll('.mapboxgl-ctrl-geocoder').forEach(geocoder => geocoder.remove());

    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address",
      placeholder: 'Adresse où les prestations sont proposées',
      countries: 'fr'
    })
    this.geocoder.addTo(this.element)

    this.geocoder.on("result", event => this.#setInputValue(event))
    this.geocoder.on("clear", () => this.#clearInputValue())


  }

  #setInputValue(event) {
    this.addressTarget.value = event.result["place_name"]
  }

  #clearInputValue() {
    this.addressTarget.value = ""
  }

  disconnect() {
    this.geocoder.onRemove()
    // Remove the geocoder instance from the element to prevent cloning issues
    // this.element.removeChild(this.geocoder.container)
    this.geocoder = null;  // Set geocoder to null when disconnecting
  }
}
