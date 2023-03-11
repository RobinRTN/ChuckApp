import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="revenu"
export default class extends Controller {
    static targets = ["content"]

    collapse(event) {
      const clickedButton = event.currentTarget;
      this.contentTarget.classList.toggle("show");
      clickedButton.classList.add("collapse-transition");
    setTimeout(() => {
      clickedButton.classList.remove("collapse-transition");
    }, 100);
    }
  }
