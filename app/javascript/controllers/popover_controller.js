import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="popover"
export default class extends Controller {
  static targets = ["togglable"];

  initialize() {}

  toggle() {
    this.togglableTarget.hidden = !this.togglableTarget.hidden;
  }

  // popover() {
  //   document.startViewTransition(() => toggle());
  // }
}
