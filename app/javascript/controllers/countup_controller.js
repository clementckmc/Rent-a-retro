import { Controller } from "@hotwired/stimulus"
import { CountUp } from 'countup.js';

// Connects to data-controller="countup"
export default class extends Controller {
  static values={
    gamesCount: Number
  }

  connect() {
    const countUp = new CountUp(this.element, this.gamesCountValue, { scrollSpyDelay: 20000, enableScrollSpy: true, duration: 10 });
    if (!countUp.error) {
      countUp.start();
    } else {
      console.error(countUp.error);
    }
  }
}
