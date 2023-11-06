// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import "./controllers";

// View transitions with Turbo
// https://github.com/palkan/turbo-view-transitions
import {
  shouldPerformTransition,
  performTransition,
} from "turbo-view-transitions";

document.addEventListener("turbo:before-render", (event) => {
  if (shouldPerformTransition()) {
    event.preventDefault();

    performTransition(document.body, event.detail.newBody, async () => {
      await event.detail.resume();
    });
  }
});

document.addEventListener("turbo:load", () => {
  // View Transitions don't play nicely with Turbo cache
  if (shouldPerformTransition()) Turbo.cache.exemptPageFromCache();
});
