import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-toggle"
export default class extends Controller {
  static targets = ["noButton", "yesButton", "fullForm", "reducedForm"];

  showFullForm(event) {
    event.preventDefault();
    this.fullFormTarget.classList.remove("d-none");
    this.reducedFormTarget.classList.add("d-none");

    // Toggle the selected class on the buttons
    this.noButtonTarget.classList.add("selected");
    this.yesButtonTarget.classList.remove("selected");
  }

  showReducedForm(event) {
    event.preventDefault();
    this.fullFormTarget.classList.add("d-none");
    this.reducedFormTarget.classList.remove("d-none");

    // Toggle the selected class on the buttons
    this.noButtonTarget.classList.remove("selected");
    this.yesButtonTarget.classList.add("selected");
  }
}
