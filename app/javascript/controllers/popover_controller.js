import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="popover"
export default class extends Controller {
  static targets = ["togglable", "slideable"];

  initialize() {
    this.slideableTarget.classList.add("duration-300", "ease-in-out");
  }

  popover() {
    this.togglableTarget.hidden ? this.slideIn() : this.slideOut();
  }

  slideIn() {
    this.togglableTarget.hidden = !this.togglableTarget.hidden;

    // Timeout required because display is being changed from none
    setTimeout(() => {
      this.slideableTarget.classList.toggle("-translate-x-full");
    }, 100);
  }

  slideOut() {
    this.slideableTarget.classList.toggle("-translate-x-full");

    // Timeout required because display is being changed to none
    setTimeout(() => {
      this.togglableTarget.hidden = !this.togglableTarget.hidden;
    }, 500);
  }
}
