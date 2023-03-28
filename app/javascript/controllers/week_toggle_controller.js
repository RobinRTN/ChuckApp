import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="week-availability"
export default class extends Controller {
  static targets = ["weekSwitch", "daySwitch"];


  toggleWeek(event) {
    const availabilityId = event.target.dataset.availabilityId;
    const weekEnabled = event.target.checked;
    // console.log(availabilityId);
    // console.log(weekEnabled);

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

    this.updateDaySwitches(weekEnabled, event.target.dataset.weekIndex);
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

    // Check if any day is enabled for the week
    const weekIndex = event.target.dataset.weekIndex;
    const daySwitchesForWeek = this.daySwitchTargets.filter(
      (daySwitch) => daySwitch.dataset.weekIndex == weekIndex
      );
    console.log("=============")
    console.log("==============")
    console.log(daySwitchesForWeek)
    const anyDayEnabled = daySwitchesForWeek.some((daySwitch) => daySwitch.checked);

    // Update the week switch accordingly
    const weekSwitch = this.weekSwitchTargets.find(
      (weekSwitch) => weekSwitch.dataset.weekIndex == weekIndex
    );

    // Ensure the week toggle is checked when at least one day is toggled
    if (anyDayEnabled) {
      weekSwitch.checked = true;
    }
  }


  updateDaySwitches(weekEnabled, weekIndex) {
    this.days_of_week = JSON.parse(this.data.get("days-of-week"));
    const daysOfWeek = this.days_of_week.map(day => `available_${day.toLowerCase()}`);
    console.log(daysOfWeek);

    const daySwitches = this.daySwitchTargets.filter(
      (daySwitch) => daySwitch.dataset.weekIndex == weekIndex
    );

    daySwitches.forEach((daySwitch) => {
      const dayAttribute = daySwitch.dataset.day; // Get the day attribute from the data-day attribute
      if (weekEnabled && daysOfWeek.includes(dayAttribute)) {
        daySwitch.checked = true;
      } else if (!weekEnabled) {
        daySwitch.checked = false;
      }
    });
  }


  getMetaContent(name) {
    const element = document.querySelector(`meta[name="${name}"]`);
    return element ? element.getAttribute("content") : null;
  }
}
