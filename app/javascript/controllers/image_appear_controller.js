import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image-appear"
export default class extends Controller {
  static targets = ["text", "image"]

  connect() {
    setTimeout(() => {
      this.showText()
    }, 1000)
    setTimeout(() => {
      this.showImage()
    }, 2000)
  }

  showText() {
    // this.textTarget.classList.remove("hidden")
    this.textTarget.classList.add("visible")
  }

  showImage() {
    // this.imageTarget.classList.remove("hidden")
    this.imageTarget.classList.add("visible")
  }
}
