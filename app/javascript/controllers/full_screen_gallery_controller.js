import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="full-screen-gallery"
// full_screen_gallery_controller.js
export default class extends Controller {
  static targets = ["image", "galleryImage", "icons"];

  connect() {
    this.currentIndex = 0;
    this.updateImage();
  }

  showImage(event) {
    console.log("showing")
    event.preventDefault();
    this.currentIndex = parseInt(event.currentTarget.dataset.index);
    console.log(this.currentIndex)
    this.updateImage();
    this.element.classList.add("full-screen-gallery-active");
    this.iconsTarget.classList.remove("d-none")
  }

  hideGallery() {
    console.log("hide triggered")
    this.element.classList.remove("full-screen-gallery-active");
    this.iconsTarget.classList.add("d-none")
  }

  prevImage() {
    console.log("previous triggered")
    this.currentIndex = (this.currentIndex - 1 + this.galleryImageTargets.length) % this.galleryImageTargets.length;
    this.updateImage();
  }

  nextImage() {
    console.log("next triggered")
    this.currentIndex = (this.currentIndex + 1) % this.galleryImageTargets.length;
    this.updateImage();
  }

  updateImage() {
    const imageUrl = this.galleryImageTargets[this.currentIndex].dataset.src;
    console.log(imageUrl)
    console.log(this.imageTarget)
    this.imageTarget.src = imageUrl;
  }
}
