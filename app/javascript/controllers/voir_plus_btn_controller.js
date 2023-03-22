import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="voir-plus-btn"
export default class extends Controller {
  static targets = ["content", "submit"]

  connect() {
    const submitButton = this.submitTarget;
    submitButton.disabled = true
    this.enableSubmitButton();
  }

  toggle(event) {
    const voirPlusButton = event.currentTarget;

    voirPlusButton.classList.add('d-none');
    this.contentTarget.classList.remove('d-none');
  }

  enableSubmitButton() {
    const submitButton = this.submitTarget;
    const selectedValue = this.selectTarget?.value;
    if (selectedValue !== "") {
      submitButton.disabled = false;
    } else {
      submitButton.disabled = true;
    }
  }

  selectChange() {
    this.enableSubmitButton();
  }
}
