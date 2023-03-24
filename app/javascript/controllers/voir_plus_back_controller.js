import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="voir-plus-back"
export default class extends Controller {
  static targets = ["content"];

  toggle(event) {
    const voirPlusButton = event.currentTarget;
    const weekIndex = voirPlusButton.dataset.weekIndex;
    const content = this.element.querySelector(`[data-week-index="${weekIndex}"][data-voir-plus-back-target="content"]`);

    content.classList.toggle("d-none");

  }
}
