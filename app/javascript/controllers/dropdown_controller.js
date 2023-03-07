import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["voirPlus", "dropDownBlock"];

  toggle(event) {
    let buttonVoirPlus = event.currentTarget;
    let dropDownBlock = buttonVoirPlus.previousElementSibling
    if (dropDownBlock.style.display === 'none') {
      dropDownBlock.style.display = 'grid';
    } else {
      dropDownBlock.style.display = 'none';
    }
    buttonVoirPlus.classList.add('d-none');
  }
}
