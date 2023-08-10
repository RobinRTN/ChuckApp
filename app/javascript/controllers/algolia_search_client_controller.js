import { Controller } from "@hotwired/stimulus"
import algoliasearch from 'algoliasearch/lite';


// Connects to data-controller="algolia-search-client"
export default class extends Controller {
  static targets = ["search", "list", "icon"];

  connect() {
    this.client = algoliasearch('99BKTJUI5I', '6f6449c50a4656e0c8d45b7e5fa92359');
    this.index = this.client.initIndex('Client');
    // console.log(this.listTarget)
  }


  search(e) {
    fetch(`/clients/search?query=${e.target.value}`)
      .then(response => response.text())
      .then(html => {
        this.listTarget.innerHTML = html;
      });
  }
}
