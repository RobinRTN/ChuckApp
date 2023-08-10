import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="onboarding-loader"
export default class extends Controller {
  static targets = [ "loader" ];

  connect() {
    // console.log("Coucou c'est moi");
  }

  submit() {
    this.loaderTarget.classList.remove("d-none"); // Show the loading animation on form submit
  }
}
