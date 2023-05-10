import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll-to-element-up"
export default class extends Controller {
  connect() {

    const observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible-up')
        }
      });
    });

    const hiddenUpElements = document.querySelectorAll(".hidden-up");
    console.log(hiddenUpElements)
    hiddenUpElements.forEach((el) => observer.observe(el));
  }
}
