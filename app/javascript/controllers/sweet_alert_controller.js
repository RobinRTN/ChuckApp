import { Controller } from "@hotwired/stimulus"
import Swal from 'sweetalert2'

export default class extends Controller {
  static targets = [ "QR-code-user" ]

  openQR() {
      const url = this.data.get("url")
      console.log(url)
      Swal.fire({
        title: 'My Title',
        text: 'My message.',
        imageUrl: url,
        imageAlt: 'QR Code',
        imageHeight: 300,
        imageWidth: 300,
        confirmButtonText: 'OK'
      })
  }
}
