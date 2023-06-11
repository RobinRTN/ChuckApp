import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-gallery-pictures"
export default class extends Controller {
  static targets = ["fileInput", "form"];

  connect() {
    console.log("fully connected")
    console.log(this.fileInputTarget)
    this.fileInputTarget.addEventListener('change', (event) => {
      if (event.target.files.length > 0) {
        this.formTarget.submit()
      }
    });  }

  addImages() {
    this.fileInputTarget.click();
  }

  submitForm() {
    console.log("submitting ....")
    this.element.querySelector('form').submit();
  }
}
