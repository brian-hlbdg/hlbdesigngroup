import "phoenix_html"
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"
import Hooks from "./hooks"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  params: {
    _csrf_token: csrfToken,
    // Send initial theme to LiveView on connect
    theme: localStorage.theme || (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light')
  },
  hooks: Hooks
})

// Connect if there are any LiveViews on the page
liveSocket.connect()

// Show progress bar on live navigation and form submits
topbar.config({
  barColors: {
    0: "#29d"
  },
  shadowColor: "rgba(0, 0, 0, .3)"
})

window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// Listen for system color scheme changes
window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', event => {
  if (!localStorage.theme) { // Only update if user hasn't manually set a preference
    if (event.matches) {
      document.documentElement.classList.add('dark')
      liveSocket.sendInfo({ theme: 'dark' })
    } else {
      document.documentElement.classList.remove('dark')
      liveSocket.sendInfo({ theme: 'light' })
    }
  }
})

// Handle theme toggle event from server
window.addEventListener("toggle-theme", (e) => {
  const theme = e.detail.theme
  if (theme === 'dark') {
    document.documentElement.classList.add('dark')
    localStorage.theme = 'dark'
  } else {
    document.documentElement.classList.remove('dark')
    localStorage.theme = 'light'
  }
})

// Expose liveSocket on window for web console debug logs and latency simulation:
window.liveSocket = liveSocket