import { Controller } from "@hotwired/stimulus"


export default class extends Controller {

  connect() {

    const observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible-bottom')
        }
      });
    });

    const hiddenLeftElements = document.querySelectorAll(".hidden-bottom-left");
    console.log(hiddenLeftElements)
    hiddenLeftElements.forEach((el) => observer.observe(el));

    const hiddenRightElements = document.querySelectorAll(".hidden-bottom-right");
    console.log(hiddenRightElements)
    hiddenRightElements.forEach((el) => observer.observe(el));

  }

}
