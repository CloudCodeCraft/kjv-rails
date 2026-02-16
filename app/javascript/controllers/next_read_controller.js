import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from "@rails/request.js"

export default class extends Controller {
   static targets = ["loading"] 
   static values = {
     url: String
   }

   connect() {
    console.log(this.loadingTarget);
    const observer = new IntersectionObserver(this.intersectionObserverCallback.bind(this), {root: null, threshold: 0.3})
    observer.observe(this.loadingTarget)
    
  }

  intersectionObserverCallback(entry, observer) {
    entry.forEach(e => {
      if (e.isIntersecting) {
      	debugger
        const requester = new FetchRequest('get', this.urlValue, { responseKind: 'turbo-stream' })
	const response = requester.perform()
      }
    })
  }

}

