import { Controller } from "@hotwired/stimulus"
import { get } from '@rails/request.js'
export default class extends Controller {
  getTurboSteam(event) {
    event.preventDefault()
    get(event.target.href, {
      contentType: "text/vnd.turbo-stream.html",
      responseKind: "turbo-stream"
    })
  }
}