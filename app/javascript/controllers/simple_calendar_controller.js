import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="simple-calendar"
export default class extends Controller {
  static targets = ['prevLink', 'nextLink', 'calendar'];

}
