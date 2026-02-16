const application = window.Stimulus;

application.debug = true

document.addEventListener("turbo:load", () => {
  const registered = application.router.modules.map(m => m.identifier)

  document.querySelectorAll("[data-controller]").forEach(el => {
    el.getAttribute("data-controller").split(" ").forEach(name => {
      if (!registered.includes(name)) {
        console.warn(`Missing Stimulus controller: ${name}`, el)
      }
    })
  })
})

