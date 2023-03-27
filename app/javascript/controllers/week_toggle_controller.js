import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="week-availability"
export default class extends Controller {
  static targets = ["weekSwitch", "daySwitch"];

  connect() {
    this.updateDaySwitches();
  }

  toggleWeek(event) {
    const availabilityId = event.target.dataset.availabilityId;
    const weekEnabled = event.target.checked;
    console.log(availabilityId);
    console.log(weekEnabled);

    // Update the server
    fetch(`/update_availability/${availabilityId}`, {
      method: "PATCH",
      body: new URLSearchParams({
        "availability_week[week_enabled]": weekEnabled,
        authenticity_token: this.getMetaContent("csrf-token"),
      }),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
    });

    this.updateDaySwitches();
  }

  toggleDay(event) {
    const availabilityId = event.target.dataset.availabilityId;
    const day = event.target.dataset.day;
    const dayEnabled = event.target.checked;

    // Update the server
    fetch(`/update_availability/${availabilityId}`, {
      method: "PATCH",
      body: new URLSearchParams({
        [`availability_week[${day}]`]: dayEnabled,
        authenticity_token: this.getMetaContent("csrf-token"),
      }),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
    });
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

  getMetaContent(name) {
    const element = document.querySelector(`meta[name="${name}"]`);
    return element ? element.getAttribute("content") : null;
  }
}
