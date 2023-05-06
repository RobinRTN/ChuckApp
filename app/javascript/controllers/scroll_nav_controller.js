import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll-nav"
export default class extends Controller {
  connect() {
    console.log('connected')
    window.addEventListener('scroll', this.handleScroll.bind(this));
  }

  disconnect() {
    window.removeEventListener('scroll', this.handleScroll.bind(this));
  }

  handleScroll() {
    const navbar = document.querySelector('.nav-bar-webflow');
    const scrollPercentage = (window.scrollY / (document.documentElement.scrollHeight - window.innerHeight)) * 100;

    if (scrollPercentage >= 7) {
      navbar.classList.add('navbar-white');
    } else {
      navbar.classList.remove('navbar-white');
    }
  }
}
