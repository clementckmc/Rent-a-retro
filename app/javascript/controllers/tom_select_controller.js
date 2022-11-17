/** @format */

import { Controller } from "@hotwired/stimulus";
import TomSelect from "tom-select";

export default class extends Controller {
  connect() {
    console.log("inside controller");
    new TomSelect(this.element);
  }
}
