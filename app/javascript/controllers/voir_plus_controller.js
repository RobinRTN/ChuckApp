import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="voir-plus"
export default class extends Controller {
  static targets = ["content"]

  toggle(event) {
    const voirPlusButton = event.currentTarget;

    voirPlusButton.classList.add('d-none');
    this.contentTarget.classList.remove('d-none');
  }
}
