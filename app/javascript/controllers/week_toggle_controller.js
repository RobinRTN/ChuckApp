import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="week-availability"
export default class extends Controller {
  static targets = ["weekSwitch", "daySwitch"];

  connect() {
    this.updateDaySwitches();
  }

  toggleWeek(event) {
    this.updateDaySwitches();
  }

  updateDaySwitches() {
    this.weekSwitchTargets.forEach((weekSwitch, index) => {
      const isChecked = weekSwitch.checked;
      const daySwitches = this.daySwitchTargets.filter(
        (daySwitch) => daySwitch.dataset.weekIndex == index
      );

      daySwitches.forEach((daySwitch) => {
        daySwitch.checked = isChecked;
      });
    });
  }
}
