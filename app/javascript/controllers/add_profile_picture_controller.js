import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "fileInputProfile", "formProfile" ]

  addImages() {
    this.fileInputProfileTarget.click()
  }

  connect() {
    this.fileInputProfileTarget.addEventListener("change", (event) => {
      if (event.target.files.length > 0) {
        this.formProfileTarget.submit()
      }
    })
  }
}
