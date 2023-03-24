import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="voir-plus-back"
export default class extends Controller {
  static targets = ["content", "icon"];

  toggle(event) {
    const voirPlusButton = event.currentTarget;
    const weekIndex = voirPlusButton.dataset.weekIndex;
    const content = this.element.querySelector(`[data-week-index="${weekIndex}"][data-voir-plus-back-target="content"]`);
    const icon = this.element.querySelector(`[data-week-index="${weekIndex}"][data-voir-plus-back-target="icon"]`);

    content.classList.toggle("d-none");
    icon.classList.toggle("fa-chevron-down");
    icon.classList.toggle("fa-chevron-up");
  }
}
