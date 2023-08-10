import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reservation"
export default class extends Controller {
  static targets = ['future', 'attente', 'passe', "buttonAttente", "buttonPasse", "buttonFuture"];

  connect() {
    // console.log("connecté");
    this.showSelectedBlock();
  }

  selectReservation(event) {
    event.preventDefault();
    const clickedButton = event.currentTarget;
    const futureBlock = this.futureTarget;
    const attenteBlock = this.attenteTarget;
    const passeBlock = this.passeTarget;
    const futureButton = this.buttonFutureTarget;
    const attenteButton = this.buttonAttenteTarget;
    const passeButton = this.buttonPasseTarget;

    // Check if there is an active block stored in local storage
    const activeBlock = localStorage.getItem("activeBlock");
    // console.log(activeBlock)

    // Remove all blocks except the active one
    if (clickedButton.id !== "reservation-passe") {
      passeBlock.style.display = 'none';
      if (activeBlock !== "reservation-passe") {
        localStorage.removeItem("activeBlock");
      }
    }
    if (clickedButton.id !== "reservation-attente") {
      attenteBlock.style.display = 'none';
      if (activeBlock !== "reservation-attente") {
        localStorage.removeItem("activeBlock");
      }
    }
    if (clickedButton.id !== "reservation-future") {
      futureBlock.style.display = 'none';
      if (activeBlock !== "reservation-future") {
        localStorage.removeItem("activeBlock");
      }
    }

    // Display selected block + change button
    if (clickedButton.id == "reservation-passe") {
      passeBlock.style.display = 'block';
      attenteButton.classList.remove('active');
      futureButton.classList.remove('active');
      passeButton.classList.add('active');
      localStorage.setItem("activeBlock", "reservation-passe");
    }
    if (clickedButton.id == "reservation-attente") {
      attenteBlock.style.display = 'block';
      futureButton.classList.remove('active');
      passeButton.classList.remove('active');
      attenteButton.classList.add('active');
      localStorage.setItem("activeBlock", "reservation-attente");
    }
    if (clickedButton.id == "reservation-future") {
      futureBlock.style.display = 'block';
      attenteButton.classList.remove('active');
      passeButton.classList.remove('active');
      futureButton.classList.add('active');
      localStorage.setItem("activeBlock", "reservation-future");
    }

    // save selected block in sessionStorage
    const selectedBlock = clickedButton.dataset.block;
    // console.log(selectedBlock)
    sessionStorage.setItem('selectedBlock', selectedBlock);
  }

  showSelectedBlock() {
    const selectedBlock = sessionStorage.getItem('selectedBlock');
    if (selectedBlock) {
      const selectedButton = this.element.querySelector(`[data-block='${selectedBlock}']`);
      if (selectedButton) {
        selectedButton.click();
      } else {
        // show default block if button not found
        this.buttonFutureTarget.click();
      }
    } else {
      // show default block if no selection found in sessionStorage
      this.buttonFutureTarget.click();
    }
  }
}
