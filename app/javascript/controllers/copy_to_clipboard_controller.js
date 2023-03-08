import { Controller } from "@hotwired/stimulus";
import ClipboardJS from "clipboard";


// Connects to data-controller="copy-to-clipboard"
export default class extends Controller {
  static targets = ["input", "disclaimer"];

  async copyText() {
    try {
      await navigator.clipboard.writeText(this.inputTarget.getAttribute("data-text"));
      this.element.classList.add("active");
      this.disclaimerTarget.style.display = 'block'
      setTimeout(() => {
        this.disclaimerTarget.style.display = 'none'
      }, 2500);
    } catch (error) {
      console.error("Failed to copy text: ", error);
    }
  }
}
