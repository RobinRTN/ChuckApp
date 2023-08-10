import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notes"
export default class extends Controller {

  static targets = [ "noteField", "noteText", "editButton", "saveButton" ]

  connect() {
    this.showNote();
  }

  showNote() {
    // console.log("show note")
    if (this.noteTextTarget.textContent.trim() === '') {
      this.noteTextTarget.classList.add('d-none')
      this.editButtonTarget.classList.add('d-none')
      this.noteFieldTarget.classList.remove('d-none')
      this.saveButtonTarget.classList.remove('d-none')
    } else {
      this.noteFieldTarget.classList.add('d-none')
      this.saveButtonTarget.classList.add('d-none')
      this.noteTextTarget.classList.remove('d-none')
      this.editButtonTarget.classList.remove('d-none')
    }
  }

  editNote() {
    // console.log("edit note")
    this.noteTextTarget.classList.add('d-none')
    this.editButtonTarget.classList.add('d-none')
    this.noteFieldTarget.classList.remove('d-none')
    this.saveButtonTarget.classList.remove('d-none')
    this.noteFieldTarget.value = this.noteTextTarget.textContent
  }

  saveNote() {

    // Get the client ID and note content from the page
  const clientId = this.data.get('clientId')
  // console.log(clientId)
  const noteContent = this.noteFieldTarget.value;
  // console.log(noteContent)


  // Define the URL for the request
  const url = `/clients/${clientId}/update_note`;

  // Define the data for the request
  const data = { note: noteContent };

  // Define the options for the request
  const options = {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
      // Ensure that your AJAX request is not treated as a cross-site request.
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
      // Send request with credentials included, in case there is any session-based
      // authentication or other session setup
      credentials: 'include'
    },
    body: JSON.stringify(data),
  };

  // Make the request
  fetch(url, options)
    .then(response => {
      if (!response.ok) {
        throw new Error("HTTP error " + response.status);
      }
      return response.json();
    })
    .then(data => {
      this.noteTextTarget.textContent = noteContent;
      this.showNote();
    })
    .catch(error => {
      console.error('There was an error saving the note:', error);
    });
  }

    // Make an AJAX request to save the note.
    // On success, update noteTextTarget's textContent and call this.showNote()

}
