import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["weekday"];

  connect() {
    this.currentDaysOfWeek = this.hiddenInput.value.split(',').filter(Boolean);

    this.weekdayTargets.forEach((weekday) => {
      if (this.currentDaysOfWeek.includes(weekday.dataset.day)) {
        weekday.classList.add("selected");
      }
    });
  }

  toggle(event) {
    const weekday = event.currentTarget;
    const day = weekday.dataset.day;

    weekday.classList.toggle("selected");

    if (weekday.classList.contains("selected")) {
      this.currentDaysOfWeek.push(day);
    } else {
      const index = this.currentDaysOfWeek.indexOf(day);
      if (index > -1) {
        this.currentDaysOfWeek.splice(index, 1);
      }
    }

    this.updateHiddenInput();
  }

  get hiddenInput() {
    return document.getElementById("hidden_days_of_week");
  }

  updateHiddenInput() {
    const weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    this.currentDaysOfWeek.sort((a, b) => weekdays.indexOf(a) - weekdays.indexOf(b));
    this.hiddenInput.value = this.currentDaysOfWeek.join(',');
    // console.log(this.hiddenInput.value)
  }
}
