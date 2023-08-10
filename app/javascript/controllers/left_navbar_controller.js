import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="left-navbar"
export default class extends Controller {
  static targets = ["navItem", "reservation"];

  connect() {
    // console.log("Connected !!!!!!!")
    this.setActiveNavItem();
  }

  setActiveNavItem() {
    // console.log("Here")
    const currentPath = window.location.pathname;
    const isBookingPage = !currentPath.startsWith("/bookings");
    this.navItemTargets.forEach((navItem) => {
      // console.log("Looping")
      const linkPath = navItem.querySelector("a").getAttribute("href");
      if (currentPath === linkPath) {
        navItem.classList.add("active");
        // check if @pending_booking is not empty and add red dot above reservation icon
        const pendingBookingId = this.data.get("pending");
        if (isBookingPage && pendingBookingId && this.reservationTarget) {
          const reservationIcon = this.reservationTarget;
          reservationIcon.innerHTML += "<span class='red-dot'></span>";
        }
      } else {
        navItem.classList.remove("active");
        const dot = navItem.querySelector(".active-dot");
        if (dot) {
          navItem.removeChild(dot);
        }
      }
    });
  }
}
