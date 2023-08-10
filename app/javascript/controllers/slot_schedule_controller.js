import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "slot", "start", "end", "rotateSchedulePending", "rotateScheduleUpdated", "submit", "displayStartTime", "displayEndTime" ]

  select(event) {
    event.preventDefault()

    let selectedElement = event.currentTarget
    let startTime = selectedElement.dataset.startTime
    let endTime = selectedElement.dataset.endTime
    // console.log(startTime)
    // console.log(endTime)

    if (selectedElement.classList.contains('selected-schedule')) {
      selectedElement.classList.remove('selected-schedule')
      this.startTarget.value = ''
      this.endTarget.value = ''

      this.rotateSchedulePendingTarget.classList.remove('d-none')
      this.rotateScheduleUpdatedTarget.classList.add('d-none')
      this.submitTarget.style.display = "none"

      this.displayStartTimeTarget.textContent = ''
      this.displayEndTimeTarget.textContent = ''
    } else {
      this.resetAllSlots()
      selectedElement.classList.add('selected-schedule')

      this.startTarget.value = startTime
      this.endTarget.value = endTime

      this.rotateSchedulePendingTarget.classList.add('d-none')
      this.rotateScheduleUpdatedTarget.classList.remove('d-none')
      this.submitTarget.style.display = "block"

      this.displayStartTimeTarget.textContent = this.formatDate(startTime)
      this.displayEndTimeTarget.textContent = this.formatDate(endTime, false)
    }
  }

  resetAllSlots() {
    this.slotTargets.forEach(element => {
      element.classList.remove('selected-schedule')
    })
  }

  formatDate(date, includeDate = true) {
    let formattedDate = new Date(date)

    const options = { weekday: 'long', day: 'numeric', month: 'long', hour: 'numeric', minute: 'numeric', hour12: false };
    let formattedTime = formattedDate.toLocaleTimeString('fr-FR', { hour: '2-digit', minute: '2-digit' }).replace(':', 'h');

    if(includeDate) {
      let formattedDayMonth = formattedDate.toLocaleDateString('fr-FR', { weekday: 'long', day: 'numeric', month: 'long' });
      formattedDayMonth = formattedDayMonth.charAt(0).toUpperCase() + formattedDayMonth.slice(1);
      return `${formattedDayMonth} ${formattedTime}`;
    } else {
      return formattedTime;
    }
  }

}
