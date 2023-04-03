import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="formule"
export default class extends Controller {
  static targets = ['formuleButton', 'formuleIdInput', 'submitButton'];

  selectFormule(event) {
    event.preventDefault();
    const clickedButton = event.currentTarget;
    const formuleId = clickedButton.value;
    const inputFormule = this.formuleIdInputTarget;

    // remove selected class from other buttons
    this.formuleButtonTargets.forEach(button => {
      if (button !== clickedButton) {
        button.classList.remove('selected');
      }
    });

    // add selected class to clicked button
    clickedButton.classList.add('selected');
    inputFormule.value = formuleId
    console.log(inputFormule.value)
    console.log(`Formule selected: ${formuleId}`);

    this.enableSubmitButton(); // call new method

  }

  enableSubmitButton() {
    const formuleId = this.formuleIdInputTarget.value;
    const submitButton = this.submitButtonTarget;

    if (formuleId) {
      submitButton.disabled = false;
    } else {
      submitButton.disabled = true;
    }
  }
}
