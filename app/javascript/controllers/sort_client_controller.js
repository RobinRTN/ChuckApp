import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sort-client"
export default class extends Controller {
  static targets = ["sortButton", "clientList"]

  connect() {
    this.sortAsc = false;
  }

  sort(e) {
    const direction = this.sortAsc ? "asc" : "desc";
    fetch(`/clients/sort?direction=${direction}`)
    .then(response => response.text())
    .then(html => {
      this.clientListTarget.innerHTML = html;
      this.sortButtonTarget.innerHTML = this.sortAsc ? '<i class="fa fa-arrow-down"></i>' : '<i class="fa fa-arrow-up"></i>' ;
      this.sortAsc = !this.sortAsc; // Flip the sort direction

    })
  }
}
