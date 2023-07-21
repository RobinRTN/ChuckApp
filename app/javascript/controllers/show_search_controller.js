import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-search"
export default class extends Controller {
  static targets = ["search", "icon"];

  show() {
    this.searchTarget.style.display = 'block';
  }
}
