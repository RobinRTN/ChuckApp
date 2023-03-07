import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bottom"
export default class extends Controller {
  static targets = ["navItem"];


  connect() {
    this.setActiveNavItem();
  }

  setActiveNavItem() {
    const currentPath = window.location.pathname;
    this.navItemTargets.forEach((navItem) => {
      const linkPath = navItem.querySelector("a").getAttribute("href");
      if (currentPath === linkPath) {
        navItem.classList.add("active");
        navItem.innerHTML += "<span class='active-dot'></span>";
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
