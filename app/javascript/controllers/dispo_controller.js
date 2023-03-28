import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dispo"
export default class extends Controller {
  static targets = [ "buttonDay", "buttonWeek", "day", "week", "refreshNeeded" ]

  connect() {
    console.log("connected")
    // Restore the last selection from localStorage, if available
    const lastBlock = localStorage.getItem("dispoLastBlock")
    if (lastBlock === "day") {
      this.buttonDayTarget.classList.add("active")
      this.buttonWeekTarget.classList.remove("active")
      this.dayTarget.style.display = "block"
      this.weekTarget.style.display = "none"
    } else {
      this.buttonDayTarget.classList.remove("active")
      this.buttonWeekTarget.classList.add("active")
      this.dayTarget.style.display = "none"
      this.weekTarget.style.display = "block"
    }

        // Set the refreshNeeded data target back to false after the page refreshes
    if (this.hasRefreshNeededTarget && this.refreshNeededTarget.dataset.value === 'true') {
      this.refreshNeededTarget.dataset.value = 'false'
    }
  }

  selectDispo(event) {
    const block = event.target.dataset.block

    // Refresh the page if refreshNeeded is set to true and the selected block is "day"

    if (block === "day") {
      this.buttonDayTarget.classList.add("active")
      this.buttonWeekTarget.classList.remove("active")
      this.dayTarget.style.display = "block"
      this.weekTarget.style.display = "none"
      localStorage.setItem("dispoLastBlock", "day")
    } else {
      this.buttonDayTarget.classList.remove("active")
      this.buttonWeekTarget.classList.add("active")
      this.dayTarget.style.display = "none"
      this.weekTarget.style.display = "block"
      localStorage.setItem("dispoLastBlock", "week")
    }
    if (block === "day" && this.refreshNeededTarget.dataset.value === 'true') {
      window.location.reload()
      return
    }
  }
}
