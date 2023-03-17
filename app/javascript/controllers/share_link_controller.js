import { Controller } from "@hotwired/stimulus"
import ClipboardJS from 'clipboard';


// Connects to data-controller="share-link"
export default class extends Controller {
  static targets = ['options', 'copyBtn'];

  slideOptions(event) {
    const clickedElement = event.currentTarget;
    // Add active class to the clicked element
    clickedElement.classList.toggle('active');

    this.optionsTarget.classList.toggle('d-none');

  }

}
