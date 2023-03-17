import { Controller } from "@hotwired/stimulus"
import ClipboardJS from 'clipboard';


// Connects to data-controller="share-link"
export default class extends Controller {
  static targets = ['options', 'copyBtn'];
  static values = {
    open: Boolean
  };

  slideOptions(event) {
    const clickedElement = event.currentTarget;
    // Add active class to the clicked element
    clickedElement.classList.add('active');

    this.openValue = !this.openValue;
    if (this.openValue) {
      this.optionsTarget.classList.add('slide-up-enter');
      this.optionsTarget.classList.remove('slide-up-leave');
      this.optionsTarget.classList.remove('d-none');
      setTimeout(() => {
        this.optionsTarget.classList.add('slide-up-enter-active');
      }, 50);
    } else {
      this.optionsTarget.classList.remove('slide-up-enter-active');
      this.optionsTarget.classList.add('slide-up-leave');
      setTimeout(() => {
        this.optionsTarget.classList.remove('slide-up-enter');
        this.optionsTarget.classList.add('d-none');

      // Remove active class from the clicked element
        clickedElement.classList.remove('active');
      }, 250);

    }
  }
}
