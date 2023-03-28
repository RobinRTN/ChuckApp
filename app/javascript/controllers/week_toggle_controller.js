import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="week-availability"
export default class extends Controller {
  static targets = ["weekSwitch", "daySwitch", "refreshNeeded"];

  async toggleWeek(event) {
    const availabilityId = event.target.dataset.availabilityId;
    const weekEnabled = event.target.checked;

    // Update the server
    await fetch(`/update_availability/${availabilityId}`, {
      method: "PATCH",
      body: new URLSearchParams({
        "availability_week[week_enabled]": weekEnabled,
        authenticity_token: this.getMetaContent("csrf-token"),
      }),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
    });

    this.updateDaySwitches(weekEnabled, event.target.dataset.weekIndex);
    this.refreshNeededTarget.dataset.value = 'true';
  }

  async toggleDay(event) {
    const availabilityId = event.target.dataset.availabilityId;
    const day = event.target.dataset.day;
    const dayEnabled = event.target.checked;

    // Update the server
    await fetch(`/update_availability/${availabilityId}`, {
      method: "PATCH",
      body: new URLSearchParams({
        [`availability_week[${day}]`]: dayEnabled,
        authenticity_token: this.getMetaContent("csrf-token"),
      }),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
    });

    // Check if any day is enabled for the week
    const weekIndex = event.target.dataset.weekIndex;
    const daySwitchesForWeek = this.daySwitchTargets.filter(
      (daySwitch) => daySwitch.dataset.weekIndex == weekIndex
    );

    const anyDayEnabled = daySwitchesForWeek.some((daySwitch) => daySwitch.checked);

    // Update the week switch accordingly
    const weekSwitch = this.weekSwitchTargets.find(
      (weekSwitch) => weekSwitch.dataset.weekIndex == weekIndex
    );

    // Check if the week switch state is different from anyDayEnabled
    if (weekSwitch.checked !== anyDayEnabled) {
      // Ensure the week toggle is checked when at least one day is toggled
      weekSwitch.checked = anyDayEnabled;

      // Update the week's state in the database
      await fetch(`/update_availability/${weekSwitch.dataset.availabilityId}`, {
        method: "PATCH",
        body: new URLSearchParams({
          "availability_week[week_enabled]": anyDayEnabled,
          authenticity_token: this.getMetaContent("csrf-token"),
        }),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      });
    }

    this.refreshNeededTarget.dataset.value = 'true';
  }


  async updateDaySwitches(weekEnabled, weekIndex) {
    this.days_of_week = JSON.parse(this.data.get("days-of-week"));
    const daysOfWeek = this.days_of_week.map(day => `available_${day.toLowerCase()}`);
    console.log(daysOfWeek);

    const daySwitches = this.daySwitchTargets.filter(
      (daySwitch) => daySwitch.dataset.weekIndex == weekIndex
    );

    // Update the day switches both in HTML and the database
    for (const daySwitch of daySwitches) {
      const dayAttribute = daySwitch.dataset.day;
      const availabilityId = daySwitch.dataset.availabilityId;
      const dayEnabled = weekEnabled && daysOfWeek.includes(dayAttribute);

      daySwitch.checked = dayEnabled;

      // Update the server
      await fetch(`/update_availability/${availabilityId}`, {
        method: "PATCH",
        body: new URLSearchParams({
          [`availability_week[${dayAttribute}]`]: dayEnabled,
          authenticity_token: this.getMetaContent("csrf-token"),
        }),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      });
    }
  }

  getMetaContent(name) {
    const element = document.querySelector(`meta[name="${name}"]`);
    return element ? element.getAttribute("content") : null;
  }
}
