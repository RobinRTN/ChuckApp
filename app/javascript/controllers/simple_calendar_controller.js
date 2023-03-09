import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="simple-calendar"
export default class extends Controller {
  static targets = [ "calendar", "previous", "next" ]

  connect() {
    // Initialize the calendar when the controller is connected
    // this.loadCalendar()
    console.log("well connected");
    console.log(this.calendarTarget.innerHTML);
    console.log(this.previousTarget.innerHTML);
    console.log(this.nextTarget.innerHTML);
  }

  // loadCalendar() {
  //   // Load the calendar using Turbo
  //   this.calendarTarget.innerHTML = "<%=j render partial: 'calendar', locals: { start_date: @start_date, date_range: @date_range, sorted_events: @sorted_events } %>"
  //   this.setTitle()
  // }

  previous() {
    // Load the previous view of the calendar using Turbo
    console.log("previous");
  }

  next() {
    // Load the next view of the calendar using Turbo
    console.log("next");
  }

  // setTitle() {
  //   // Set the calendar title to match the current view
  //   const title = this.calendarTarget.querySelector('.calendar-title').innerText
  //   this.titleTarget.innerText = title
  // }
}
