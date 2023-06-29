import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static values = {
		duration: { type: Number, default: 3000 } // milliseconds
	}

	connect() {
		this.startTimeOut()
		this.hasTimeOut = true
	}

	startTimeOut() {
		if (this.hasTimeOut) { return }

		this.hasTimeOut = true
		this.timeout = setTimeout(this.remove.bind(this), this.durationValue);
	}

	stopTimeout() {
		this.hasTimeOut = false
		clearTimeout(this.timeout)
	}

	remove() {
		this.element.classList.add('slide-right')
    setTimeout(() => {
		this.element.remove()
    }, 750);
	}
}
