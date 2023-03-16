import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="formule"
export default class extends Controller {
  static targets = ['formuleButton', 'formuleIdInput', 'optionButtonOui', 'optionButtonNon', 'optionInput', 'submitButton'];

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

  selectOption(event) {
    event.preventDefault();
    const clickedButton = event.currentTarget;
    const optionValue = clickedButton.value;
    const ouiButton = this.optionButtonOuiTarget
    const nonButton = this.optionButtonNonTarget
    const inputOption = this.optionInputTarget;
    console.log(this.optionButtonOuiTarget)

    // remove selected class from other buttons
    if (ouiButton !== clickedButton) {
      ouiButton.classList.remove('selected');
    }
    if (nonButton !== clickedButton) {
      nonButton.classList.remove('selected');
    }
    clickedButton.classList.add('selected');
    inputOption.value = optionValue
    console.log(inputOption.value)
    console.log(`Option selected: ${optionValue}`);

    this.enableSubmitButton(); // call new method

  }

  enableSubmitButton() {
    const formuleId = this.formuleIdInputTarget.value;
    const optionValue = this.optionInputTarget.value;
    const submitButton = this.submitButtonTarget;

    if (formuleId && optionValue) {
      submitButton.disabled = false;
    } else {
      submitButton.disabled = true;
    }
  }

  // checkForm(event) {
  //   const form = event.currentTarget;

  //   const formuleButton = form.querySelector('button[name="formule_id"].selected');
  //   const bookingOptionButton = form.querySelector('button[name="booking_option"].selected');

  //   if (!formuleButton) {
  //     alert('Veuillez sélectionner une formule');
  //     event.preventDefault();
  //   }

  //   if (!bookingOptionButton) {
  //     alert('Veuillez sélectionner une option de réservation');
  //     event.preventDefault();
  //   }
  // }

}
