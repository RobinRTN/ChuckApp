import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="week-availability"
export default class extends Controller {
  static targets = ["weekToggle"];

  toggleWeek(event) {
    const weekCheckbox = event.currentTarget;
    const weekCard = weekCheckbox.closest("[data-week-availability-id]");
    const dayToggleCards = weekCard.querySelectorAll("[data-controller=day-availability]");

    dayToggleCards.forEach((card) => {
      const dayCheckbox = card.querySelector("[data-target=day-availability.toggle]");
      dayCheckbox.checked = weekCheckbox.checked;
      dayCheckbox.disabled = !weekCheckbox.checked;
      dayCheckbox.dispatchEvent(new Event("change", { bubbles: true }));
    });
  }
}
