import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="datetime"
export default class extends Controller {
  static targets = ["datetimeButton", "displayDatetime"];

  connect() {
    // console.log("well connected")
  }

  setActiveDateTime(event) {
    event.preventDefault();
    const clickedButton = event.currentTarget;
    const datetime = clickedButton.dataset.datetime;

    // Remove active class from previously active button
    this.datetimeButtonTargets.forEach((button) => {
      button.classList.remove("active");
    });

    // Add active class to the clicked button
    clickedButton.classList.add("active");

    // Update displayed datetime
    this.displayDatetimeTarget.textContent = datetime;
    document.getElementById("datetime").value = datetime;

  }
}
