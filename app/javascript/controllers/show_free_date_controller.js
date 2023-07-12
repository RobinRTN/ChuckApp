import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-free-date"
export default class extends Controller {
  static targets = [ "freeForm", "default", "button" ]

  connect() {
    this.originalButtonText = this.buttonTarget.innerText;
  }

  toggle() {
    this.freeFormTarget.classList.toggle('d-none');
    this.defaultTarget.classList.toggle('d-none');
    this.buttonTarget.innerText = this.buttonTarget.innerText == this.originalButtonText ? "Retour" : this.originalButtonText;
  }
}

