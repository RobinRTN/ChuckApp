import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll-top"
export default class extends Controller {
  connect() {
    this.scrollFunction();
    window.onscroll = () => this.scrollFunction();
  }

  scrollFunction() {
    if (window.pageYOffset > window.innerHeight) {
      this.element.style.opacity = "0.9";
    } else {
      this.element.style.opacity = "0";
    }
  }

  goTop() {
    console.log("scroll top")
    document.body.scrollTop = 0;
    document.documentElement.scrollTop = 0;
  }
}
