import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="revenu"
export default class extends Controller {
    static targets = ["content"]

    collapse() {
      this.contentTarget.classList.toggle("show")
    }
  }
