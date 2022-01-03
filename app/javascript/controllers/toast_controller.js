import { Controller } from "stimulus";

export default class ToastController extends Controller {
  Success(event) {
    $(".toast-error").addClass("d-hide");
    $(".toast-success").removeClass("d-hide");
  }

  Error(event) {
    $(".toast-success").addClass("d-hide");
    $(".toast-error").removeClass("d-hide");
  }
}