import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="revenu"
export default class extends Controller {
  connect() {
    console.log("well connected")
  }

  insertDateRevenu() {
    console.log("CLICK DATE")
  }

  insertMonthRevenu() {
    console.log("CLICK MONTH")
  }

}
