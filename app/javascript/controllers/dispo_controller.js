import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dispo"
export default class extends Controller {
  static targets = [ "buttonDay", "buttonContact", "day", "contact" ]

  connect() {
    // Restore the last selection from localStorage, if available
    const lastBlock = localStorage.getItem("clientLastBlock")
    if (lastBlock === "day") {
      this.buttonDayTarget.classList.add("active")
      this.buttonContactTarget.classList.remove("active")
      this.dayTarget.style.display = "block"
      this.contactTarget.style.display = "none"
    } else {
      this.buttonDayTarget.classList.remove("active")
      this.buttonContactTarget.classList.add("active")
      this.dayTarget.style.display = "none"
      this.contactTarget.style.display = "block"
    }
  }

  selectClient(event) {
    const block = event.target.dataset.block

    if (block === "groupe") {
      this.buttonGroupeTarget.classList.add("active")
      this.buttonContactTarget.classList.remove("active")
      this.groupeTarget.style.display = "block"
      this.contactTarget.style.display = "none"
      localStorage.setItem("clientLastBlock", "groupe")
    } else {
      this.buttonGroupeTarget.classList.remove("active")
      this.buttonContactTarget.classList.add("active")
      this.groupeTarget.style.display = "none"
      this.contactTarget.style.display = "block"
      localStorage.setItem("clientLastBlock", "contact")
    }
  }
}
