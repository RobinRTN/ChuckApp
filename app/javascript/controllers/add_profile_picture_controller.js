import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "fileInputProfile", "formProfile", "loader" ]

  addImages() {
    this.fileInputProfileTarget.click()
  }

  connect() {
    this.fileInputProfileTarget.addEventListener("change", (event) => {
      if (event.target.files.length > 0) {
        this.formProfileTarget.submit()
      }
      this.loaderTarget.classList.remove("d-none"); // Show the loading animation on form submit
    })
  }
}
