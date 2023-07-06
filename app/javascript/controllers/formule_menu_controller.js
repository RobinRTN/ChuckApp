import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  connect() {
    console.log("Formule Menu Controller Connected")
  }
  removeRecord(event) {
    event.preventDefault();
    console.log("Remove Record Triggered")
    event.target.previousElementSibling.value = '1';
    event.target.closest('.formule-fields').style.display = 'none';
  }

  addFields(event) {
    event.preventDefault();
    console.log(event)
    console.log("Add Fields Triggered")
    let time = new Date().getTime();
    let regexp = new RegExp(event.target.dataset.id, 'g');
    document.querySelector('.fields').insertAdjacentHTML('afterbegin', event.target.dataset.fields.replace(regexp, time));
  }
}
