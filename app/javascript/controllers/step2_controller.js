import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="step2"
export default class extends Controller {
  static targets = ["noButton", "yesButton", "fixForm", "multipleForm"];

  connect() {
    // Called when the controller is connected
    this.loadSelection();

  }

  loadSelection() {
    const selection = localStorage.getItem('selection');

    if (selection === 'fix') {
      this.showFixForm();
    } else if (selection === 'multiple') {
      this.showMultipleForm();
    }
  }

  showFixForm(event) {
    if (event) event.preventDefault();
    this.fixFormTarget.classList.remove("d-none");
    this.multipleFormTarget.classList.add("d-none");

    // Toggle the selected class on the buttons
    this.yesButtonTarget.classList.add("selected");
    this.noButtonTarget.classList.remove("selected");

    localStorage.setItem('selection', 'fix');
  }

  showMultipleForm(event) {
    if (event) event.preventDefault();
    this.fixFormTarget.classList.add("d-none");
    this.multipleFormTarget.classList.remove("d-none");

    // Toggle the selected class on the buttons
    this.yesButtonTarget.classList.remove("selected");
    this.noButtonTarget.classList.add("selected");

    localStorage.setItem('selection', 'multiple');
  }
}
