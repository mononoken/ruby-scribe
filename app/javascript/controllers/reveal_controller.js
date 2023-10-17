import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="reveal"
export default class extends Controller {
  static targets = ["revealable"];

  initialize() {}

  toggle() {
    this.revealableTarget.hidden = !this.revealableTarget.hidden;
  }

  reveal() {}

  hide() {}
}
