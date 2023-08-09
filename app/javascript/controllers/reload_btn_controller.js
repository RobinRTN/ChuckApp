import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["notice"]

  connect() {
    this.#run()
  }

  reload(e) {
    e.preventDefault()
    localStorage.setItem("reloaded", true)
    window.location.reload()
  }

  #run() {
    if (localStorage.getItem("reloaded") === "true") {
      this.#fadeIn()
      setTimeout(() => {
        this.#fadeOut()
      }, 1000)
    }

    localStorage.setItem("reloaded", "false")
  }

  #fadeIn() {
    this.noticeTarget.classList.add("fade-in")
    this.noticeTarget.classList.remove("d-none")
  }

  #fadeOut() {
    this.noticeTarget.classList.remove("fade-in")
    this.noticeTarget.classList.add("fade-out")
    setTimeout(() => {
      this.noticeTarget.classList.add("d-none")
      this.noticeTarget.classList.remove("fade-out")
    }, 300)
  }
}
