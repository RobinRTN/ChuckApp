import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  connect() {
    console.log("COOONNNNEEECCTTTEDD")
  }
  removeRecord(event) {
    console.log("SSUPPPRRR")
    event.preventDefault();
    event.target.previousElementSibling.value = '1';
    event.target.closest('.formule-fields').style.display = 'none';
  }

  addFields(event) {
    console.log("AASDDDDDD")
    event.preventDefault();
    let time = new Date().getTime();
    let regexp = new RegExp(event.target.dataset.id, 'g');
    document.querySelector('.fields').insertAdjacentHTML('beforeend', event.target.dataset.fields.replace(regexp, time));
  }
}
