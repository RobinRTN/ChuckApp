import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["formule", "formuleCount", "package"];

  connect() {
    // console.log('connecté au JS de Add Formule')
    // console.log('packages:')
    // console.log(this.packageTargets)
    // console.log('formules:')
    // console.log(this.formuleTargets)
  }

  newFormule(event) {
    // console.log("newFormule action well activated")
    event.preventDefault();

    const newFormule = this.formuleTargets[this.formuleTargets.length - 1].cloneNode(true);

    newFormule.querySelectorAll("input, select, textarea").forEach(input => {
      // console.log(input)
      const name = input.getAttribute('name');
      // console.log(name)
      const id = input.getAttribute('id');
      // console.log(id)
      if (name && id) { // Check if name and id are not null
        const matches = name.match(/\[([^\]]+)\]/g);
        const key = matches[matches.length - 1].replace(/[\[\]']+/g, '');
        const packageIndexMatches = name.match(/user\[packages_attributes\]\[(\d+)\]\[formules_attributes\]\[(\d+)\]/);
        const packageIndex = packageIndexMatches[1];
        const formuleIndex = parseInt(packageIndexMatches[2]) + 1;

        input.setAttribute('name', `user[packages_attributes][${packageIndex}][formules_attributes][${formuleIndex}][${key}]`);
        input.setAttribute('id', `user_packages_attributes_${packageIndex}_formules_attributes_${formuleIndex}_${key}`);
        input.value = "";
      }
    });

    newFormule.querySelector("select").selectedIndex = 0;

    newFormule.querySelector(".delete-formule").classList.remove("d-none");

    event.currentTarget.parentNode.insertBefore(newFormule, event.currentTarget);
  }

  deleteFormule(event) {
    event.preventDefault();

    const formuleToDelete = event.currentTarget.closest(".formules-step2-child");
    formuleToDelete.remove();
  }

  newPackage(event) {
    // console.log("starting to create a new package")
    event.preventDefault();

    const newPackage = this.packageTargets[this.packageTargets.length - 1].cloneNode(true);

    newPackage.querySelectorAll("input, select, textarea").forEach(input => {
      const name = input.getAttribute('name');
      const id = input.getAttribute('id');
      if (name && id) { // Check if name and id are not null
        const matches = name.match(/user\[packages_attributes\]\[(\d+)\]/);
        const packageIndex = parseInt(matches[1]) + 1;
        const packageRegex = /user\[packages_attributes\]\[\d+\]/;
        const packageMatchLength = name.match(packageRegex)[0].length;

        input.setAttribute('name', `user[packages_attributes][${packageIndex}]${name.slice(packageMatchLength)}`);
        input.setAttribute('id', `user_packages_attributes_${packageIndex}_${id.slice(packageMatchLength - 1)}`);

        input.value = "";
      }
    });

    newPackage.querySelectorAll("select").forEach(select => {
      select.selectedIndex = 0;
    });

    const formules = newPackage.querySelectorAll(".formules-step2-child");
    formules.forEach((formule, index) => {
      if (index !== 0) {
        formule.parentNode.removeChild(formule);
      }
    });

    newPackage.querySelector(".delete-package").classList.remove("d-none");

    event.currentTarget.parentNode.insertBefore(newPackage, event.currentTarget);

    const firstFormuleDeleteButton = newPackage.querySelector(".formules-step2-child .delete-formule");
    if (firstFormuleDeleteButton) {
      firstFormuleDeleteButton.classList.add("d-none");
    }


  }

  deletePackage(event) {
    event.preventDefault();

    const packageToDelete = event.currentTarget.closest(".package-step2");

    packageToDelete.remove();
  }

}




/* <input class="form-control string required" placeholder="Catégorie de prestations" autofocus="autofocus" required="required" aria-required="true" type="text" name="user[packages_attributes][0][name]" id="user_packages_attributes_0_name"></input>
<input class="form-control string required" placeholder="Catégorie de prestations" autofocus="autofocus" required="required" aria-required="true" type="text" name="user[packages_attributes][1][name]" id="user_packages_attributes_1_name"></input>
<input class="form-control string required" placeholder="Nom de la prestation" autofocus="autofocus" required="required" aria-required="true" type="text" name="user[packages_attributes][0][formules_attributes][0][name]" id="user_packages_attributes_0_formules_attributes_0_name"></input>
<input class="form-control string required" placeholder="Nom de la prestation" autofocus="autofocus" required="required" aria-required="true" type="text" name="user[packages_attributes][1][formules_attributes][0][name]" id="user_packages_attributes_1_formules_attributes_0_name"></input> */


/* <input class="form-control string required" placeholder="Catégorie de prestations" autofocus="autofocus" required="required" aria-required="true" type="text" name="user[packages_attributes][0][name]" id="user_packages_attributes_0_name"></input>
<input class="form-control string required" placeholder="Nom de la prestation" autofocus="autofocus" required="required" aria-required="true" type="text" name="user[packages_attributes][0][formules_attributes][0][name]" id="user_packages_attributes_0_formules_attributes_0_name"></input>
<input class="form-control string required" placeholder="Nom de la prestation" autofocus="autofocus" required="required" aria-required="true" type="text" name="user[packages_attributes][1][formules_attributes][2]" id="user_packages_attributes_1_formules_attributes_2_name">

<input class="form-control string required" placeholder="Catégorie de prestations" autofocus="autofocus" required="required" aria-required="true" type="text" name="user[packages_attributes][1][name]" id="user_packages_attributes_1_name"></input>
<input class="form-control string required" placeholder="Nom de la prestation" autofocus="autofocus" required="required" aria-required="true" type="text" name="user[packages_attributes][1][formules_attributes][1]" id="user_packages_attributes_1_formules_attributes_1_name"></input>
<input class="form-control string required" placeholder="Nom de la prestation" autofocus="autofocus" required="required" aria-required="true" type="text" name="user[packages_attributes][1][formules_attributes][2]" id="user_packages_attributes_1_formules_attributes_2_name"></input> */
