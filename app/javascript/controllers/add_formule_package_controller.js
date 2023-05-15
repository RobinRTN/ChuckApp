import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["formule", "formuleCount", "package"];

  newFormule(event) {
    event.preventDefault();

    // Here we're just cloning the last ".formules-step2-child" we find.
    const newFormule = this.formuleTargets[this.formuleTargets.length - 1].cloneNode(true);

    // Clear the input values in the cloned node
    newFormule.querySelectorAll("input").forEach(input => {
      input.value = "";
    });

    // Remove selected state from select
    newFormule.querySelector("select").selectedIndex = 0;

    // Update the formule count in the new node
    // newFormule.querySelector("[data-add-formule-package-target='formuleCount']").textContent = `Prestation ${this.formuleTargets.length + 1}`;

    // Make the "Supprimer" button visible in the new node
    newFormule.querySelector(".delete-formule").classList.remove("d-none");

    // Append the cloned node to the form
    event.currentTarget.parentNode.insertBefore(newFormule, event.currentTarget);
  }

  deleteFormule(event) {
    event.preventDefault();

    // Get the parent ".formules-step2-child" of the clicked delete button
    const formuleToDelete = event.currentTarget.closest(".formules-step2-child");

    // Remove it from the DOM
    formuleToDelete.remove();
  }

  newPackage(event) {
    event.preventDefault();

    // Clone the last ".package-step2" we find.
    const newPackage = this.packageTargets[this.packageTargets.length - 1].cloneNode(true);

    // Clear the input values in the cloned node
    newPackage.querySelectorAll("input").forEach(input => {
      input.value = "";
    });

    // Remove selected state from select
    newPackage.querySelectorAll("select").forEach(select => {
      select.selectedIndex = 0;
    });

    // Keep only the first formule and remove the others
    const formules = newPackage.querySelectorAll(".formules-step2-child");
    formules.forEach((formule, index) => {
      if (index !== 0) {
        formule.parentNode.removeChild(formule);
      }
    });

    // Make the "Supprimer" button visible in the new node
    newPackage.querySelector(".delete-package").classList.remove("d-none");

    // Append the cloned node to the form
    event.currentTarget.parentNode.insertBefore(newPackage, event.currentTarget);

    // Hide the delete button in the first formule of the new package
    const firstFormuleDeleteButton = newPackage.querySelector(".formules-step2-child .delete-formule");
    if (firstFormuleDeleteButton) {
      firstFormuleDeleteButton.classList.add("d-none");
    }
  }

  deletePackage(event) {
    event.preventDefault();

    // Get the parent ".package-step2" of the clicked delete button
    const packageToDelete = event.currentTarget.closest(".package-step2");

    // Remove it from the DOM
    packageToDelete.remove();
  }

}
