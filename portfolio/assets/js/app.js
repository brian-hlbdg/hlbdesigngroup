import "phoenix_html"
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"
import Hooks from "./hooks"

// Configure topbar for nice loading indicator
topbar.config({
  barColors: {
    0: "rgba(211, 84, 0, 0.7)", // Primary color with transparency
    ".3": "rgba(211, 84, 0, 0.8)",
    ".5": "rgba(211, 84, 0, 0.9)",
    ".7": "rgba(211, 84, 0, 1)"
  }, 
  shadowColor: "rgba(0, 0, 0, .3)",
  className: 'topbar'
});

// Session storage for persistence between page loads
const getStoredTheme = () => localStorage.getItem('theme') || 'light';
const setStoredTheme = theme => localStorage.setItem('theme', theme);

// Handle theme toggling
const setupTheme = () => {
  const theme = getStoredTheme();
  document.documentElement.classList.toggle('dark', theme === 'dark');
  
  // Setup theme toggle if it exists
  const themeToggle = document.getElementById('theme-toggle');
  if (themeToggle) {
    themeToggle.addEventListener('click', () => {
      const newTheme = getStoredTheme() === 'dark' ? 'light' : 'dark';
      setStoredTheme(newTheme);
      document.documentElement.classList.toggle('dark', newTheme === 'dark');
    });
  }
};

// Initialize LiveSocket with all our hooks and configurations
let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");
let liveSocket = new LiveSocket("/live", Socket, {
  params: {_csrf_token: csrfToken},
  hooks: Hooks,
  dom: {
    onBeforeElUpdated(from, to) {
      // Keep classes that might be added by Alpine or other libraries
      if (from._x_dataStack) {
        window.Alpine.clone(from, to);
      }
    }
  }
})

// Page transition effects
window.addEventListener("phx:page-loading-start", () => topbar.show(300));
window.addEventListener("phx:page-loading-stop", () => {
  topbar.hide();
  setupTheme();
  
  // Trigger animations for elements that should animate on page load
  document.querySelectorAll('.animate-on-load').forEach(el => {
    el.classList.add('animate-fadeIn');
  });
});

// Initialize when document loads
document.addEventListener("DOMContentLoaded", () => {
  setupTheme();
});

// Connect if there are any LiveViews on the page
liveSocket.connect();

// Make LiveSocket available for debugging and latency simulation
window.liveSocket = liveSocket;