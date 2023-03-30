import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="full-screen-gallery"
// full_screen_gallery_controller.js
export default class extends Controller {
  static targets = ["image", "galleryImage", "icons", "spinner", "smallSpinner"];

  connect() {
    this.currentIndex = 0;
    this.updateImage();
    this.loadSmallImages();
  }

  showImage(event) {
    console.log("showing");
    event.preventDefault();
    this.currentIndex = parseInt(event.currentTarget.dataset.index);
    console.log(this.currentIndex);
    this.updateImage();
    this.element.classList.add("full-screen-gallery-active");
    this.iconsTarget.classList.remove("d-none");
  }

  hideGallery() {
    console.log("hide triggered");
    this.element.classList.remove("full-screen-gallery-active");
    this.iconsTarget.classList.add("d-none");
  }

  prevImage() {
    console.log("previous triggered");
    this.currentIndex = (this.currentIndex - 1 + this.galleryImageTargets.length) % this.galleryImageTargets.length;
    this.updateImage();
  }

  nextImage() {
    console.log("next triggered");
    this.currentIndex = (this.currentIndex + 1) % this.galleryImageTargets.length;
    this.updateImage();
  }

  updateImage() {
    const imageUrl = this.galleryImageTargets[this.currentIndex].dataset.src;
    console.log(imageUrl);
    console.log(this.imageTarget);

    this.showSpinner();

    this.imageTarget.onload = () => {
      this.hideSpinner();
    };

    this.imageTarget.src = imageUrl;
  }

  showSpinner() {
    this.spinnerTarget.classList.remove("d-none");
  }

  hideSpinner() {
    this.spinnerTarget.classList.add("d-none");
  }

  loadSmallImages() {
    this.galleryImageTargets.forEach((img, index) => {
      const smallImg = new Image();
      smallImg.src = img.src;

      smallImg.onload = () => {
        this.smallSpinnerTargets[index].classList.add("d-none");
      };
    });
  }
}
