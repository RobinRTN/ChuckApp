import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content", "submit", "select"];

  connect() {
    this.enableSubmitButton();
  }

  toggle(event) {
    const voirPlusButton = event.currentTarget;
    voirPlusButton.classList.add("d-none");
    this.contentTarget.classList.remove("d-none");
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
