import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["navbar"];

  connect() {
    // console.log('connected')
    window.addEventListener('scroll', this.handleScroll.bind(this));
  }

  disconnect() {
    window.removeEventListener('scroll', this.handleScroll.bind(this));
  }

  handleScroll() {
    const navbar = this.navbarTarget;

    const scrollPercentage = (window.scrollY / (document.documentElement.scrollHeight - window.innerHeight)) * 100;

    if (scrollPercentage >= 7) {
      navbar.classList.add('navbar-white');
    } else {
      navbar.classList.remove('navbar-white');
    }
  }
}
