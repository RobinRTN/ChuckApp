import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ "formule" ]

  connect () {

      console.log('HELLLLOOO')
      console.log(this.formuleTargets)
  }

  addFormule(event) {
    console.log("addFormule action well activated")
    event.preventDefault();


    // Cloning last formule form
    const newFormule = this.formuleTargets[this.formuleTargets.length - 2].cloneNode(true);

    console.log(newFormule)

    // Getting the highest formule index in order to set proper indices for the new fields
    const formuleIndices = this.formuleTargets.map(target => {
      const nameAttr = target.querySelector('input, select, textarea').getAttribute('name');
      const matches = nameAttr.match(/user\[formules_attributes\]\[(\d+)\]/);
      return parseInt(matches[1]);
    });
    const newFormuleIndex = Math.max(...formuleIndices) + 1;

    newFormule.querySelectorAll("input, select, textarea").forEach(input => {
      const name = input.getAttribute('name');
      const id = input.getAttribute('id');
      if (name && id) { // Check if name and id are not null
        const matches = name.match(/\[([^\]]+)\]/g);
        const key = matches[matches.length - 1].replace(/[\[\]']+/g, '');
        input.setAttribute('name', `user[formules_attributes][${newFormuleIndex}][${key}]`);
        input.setAttribute('id', `user_formules_attributes_${newFormuleIndex}_${key}`);
        input.value = "";
        input.classList.remove("is-valid");

      }
    });

    newFormule.querySelector(".nested-fields").dataset.newRecord = "true";

    newFormule.querySelector("select").selectedIndex = 0;

    newFormule.querySelector(".delete-formule").classList.remove("d-none");

    event.currentTarget.parentNode.insertBefore(newFormule, event.currentTarget);
  }


  deleteFormule(event) {

    event.preventDefault();

    const formuleToDelete = event.currentTarget.closest(".formules-step2-child");

    // Set the _destroy attribute to mark the formule for deletion
    const destroyInput = formuleToDelete.querySelector("input[name*='_destroy']");
    destroyInput.value = "1";

    formuleToDelete.remove();
  }

    // const formuleFields = event.target.closest(".nested-fields");
  //   if (formuleFields.dataset.newRecord == "true") {
  //     formuleFields.remove();
  //     console.log("NEWWWWWW")
  //   } else {
  //     formuleFields.querySelector("input[name$='[_destroy]']").value = 1;
  //     formuleFields.style.display = "none";
  //   }
  // }
}
