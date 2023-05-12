import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="step2"
export default class extends Controller {
  static targets = ["noButton", "yesButton", "fixForm", "multipleForm"];

  showFixForm(event) {
    event.preventDefault();
    this.fixFormTarget.classList.remove("d-none");
    this.multipleFormTarget.classList.add("d-none");

    // Toggle the selected class on the buttons
    this.yesButtonTarget.classList.add("selected");
    this.noButtonTarget.classList.remove("selected");
  }

  showMultipleForm(event) {
    event.preventDefault();
    this.fixFormTarget.classList.add("d-none");
    this.multipleFormTarget.classList.remove("d-none");

    // Toggle the selected class on the buttons
    this.yesButtonTarget.classList.remove("selected");
    this.noButtonTarget.classList.add("selected");
  }
}
