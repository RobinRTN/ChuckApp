import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bottom"
export default class extends Controller {
  static targets = ["navItem", "reservation", "pending"];


  connect() {
    this.setActiveNavItem();
  }

  setActiveNavItem() {
    const currentPath = window.location.pathname;
    const isBookingPage = !currentPath.startsWith("/bookings");
    this.navItemTargets.forEach((navItem) => {
      const linkPath = navItem.querySelector("a").getAttribute("href");
      if (currentPath === linkPath) {
        navItem.classList.add("active");
        navItem.innerHTML += "<span class='active-dot'></span>";

        // check if @pending_booking is not empty and add red dot above reservation icon
        const pendingBookingId = this.data.get("pending");
        console.log("PendingBookingID:")
        console.log(pendingBookingId);
        console.log(isBookingPage);
        console.log(this.hasReservationIconTarget);
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
