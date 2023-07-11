import { Controller } from "@hotwired/stimulus"
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "slot", "start", "end", "displayStartTime", "displayEndTime", "rotateSchedulePending", "rotateScheduleUpdated", "submit" ]

  weekdays = ["Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"];
  months = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"];

  select(event) {
    const element = event.currentTarget;
    this.slotTargets.forEach((el) => {
      el.classList.remove("selected-schedule");
    });
    element.classList.add("selected-schedule");
    const start_time = element.dataset.startTime;
    const end_time = element.dataset.endTime;
    this.startTarget.value = start_time;
    this.endTarget.value = end_time;
    this.displayStartTimeTarget.textContent = this.formatTime(start_time);
    this.displayEndTimeTarget.textContent = this.formatTime(end_time, false);
    this.rotateSchedulePendingTarget.classList.add('d-none');
    this.rotateScheduleUpdatedTarget.classList.remove('d-none');
    this.submitTarget.style.display = 'block';
  }

  formatTime(timeString, includeDate = true) {
    let now = new Date();
    let [hours, minutes] = timeString.split(":");
    let date = new Date(now.getFullYear(), now.getMonth(), now.getDate(), hours, minutes);
    let formattedTime = `${hours}h${minutes}`;

    if (includeDate) {
      let dayName = this.weekdays[date.getDay()];
      let day = date.getDate();
      let monthName = this.months[date.getMonth()];
      return `${dayName} ${day} ${monthName} ${formattedTime}`;
    } else {
      return formattedTime;
    }
  }
}
