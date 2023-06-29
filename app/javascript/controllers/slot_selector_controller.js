import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slot"];

  connect() {
    const parsedValue = JSON.parse(this.hiddenInput.value);
    this.excludedFixedWeeklySlots = Array.isArray(parsedValue) ? parsedValue : [];
    this.refreshSlots();
  }

  refreshSlots() {
    this.slotTargets.forEach((slot) => {
      const day = slot.dataset.day;
      const startTime = slot.dataset.startTime;
      const endTime = slot.dataset.endTime;

      if (this.excludedFixedWeeklySlots.some(([d, st, et]) => d == day && st == startTime && et == endTime)) {
        slot.classList.add('selected');
      } else {
        slot.classList.remove('selected');
      }
    });
  }

  toggle(event) {
    const slot = event.currentTarget;
    const day = slot.dataset.day;
    const startTime = slot.dataset.startTime;
    const endTime = slot.dataset.endTime;

    slot.classList.toggle("selected");

    if (slot.classList.contains("selected")) {
      this.excludedFixedWeeklySlots.push([day, startTime, endTime]);
    } else {
      const index = this.excludedFixedWeeklySlots.findIndex(slot => slot[0] == day && slot[1] == startTime && slot[2] == endTime);
      if (index > -1) {
        this.excludedFixedWeeklySlots.splice(index, 1);
      }
    }

    this.updateHiddenInput();
  }

  get hiddenInput() {
    return document.getElementById("hidden_excluded_fixed_weekly_slots");
  }

  updateHiddenInput() {
    this.hiddenInput.value = JSON.stringify(this.excludedFixedWeeklySlots);
  }
}
