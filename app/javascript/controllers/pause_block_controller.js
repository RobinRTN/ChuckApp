import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pause-block"
export default class extends Controller {
  static targets = ["input", "oui", "non"]

  connect() {
    
  }
}
