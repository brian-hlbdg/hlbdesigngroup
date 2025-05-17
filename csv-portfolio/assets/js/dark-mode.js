// /csv-portfolio/assets/js/dark-mode.js

/**
 * Dark Mode functionality handler
 * Manages dark mode toggle functionality and persists user preference
 */
class DarkMode {
    constructor() {
      this.init();
    }
  
    /**
     * Initialize dark mode functionality
     */
    init() {
      // Set up toggle button listeners
      this.setupToggleButtons();
      
      // Update button state on load
      this.updateToggleButtons(document.documentElement.classList.contains('dark') ? 'dark' : 'light');
  
      // Listen for system theme changes
      window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', (e) => {
        if (!localStorage.getItem('theme')) {
          if (e.matches) {
            this.enableDarkMode();
          } else {
            this.enableLightMode();
          }
        }
      });
    }
  
    /**
     * Enable dark mode
     */
    enableDarkMode() {
      document.documentElement.classList.add('dark');
      localStorage.setItem('theme', 'dark');
      this.updateToggleButtons('dark');
    }
  
    /**
     * Enable light mode
     */
    enableLightMode() {
      document.documentElement.classList.remove('dark');
      localStorage.setItem('theme', 'light');
      this.updateToggleButtons('light');
    }
  
    /**
     * Toggle between dark and light mode
     */
    toggle() {
      if (document.documentElement.classList.contains('dark')) {
        this.enableLightMode();
      } else {
        this.enableDarkMode();
      }
    }
  
    /**
     * Set up event listeners for toggle buttons
     */
    setupToggleButtons() {
      const toggleButtons = document.querySelectorAll('[data-theme-toggle]');
      toggleButtons.forEach(button => {
        button.addEventListener('click', () => this.toggle());
      });
    }
  
    /**
     * Update toggle button appearance based on current theme
     * @param {string} theme - 'dark' or 'light'
     */
    updateToggleButtons(theme) {
      const toggleButtons = document.querySelectorAll('[data-theme-toggle]');
      toggleButtons.forEach(button => {
        const lightIcon = button.querySelector('.light-icon');
        const darkIcon = button.querySelector('.dark-icon');
        
        if (theme === 'dark') {
          if (lightIcon) lightIcon.style.display = 'none';
          if (darkIcon) darkIcon.style.display = 'inline';
        } else {
          if (lightIcon) lightIcon.style.display = 'inline';
          if (darkIcon) darkIcon.style.display = 'none';
        }
      });
    }
  }
  
  // Initialize when DOM is loaded
  document.addEventListener('DOMContentLoaded', () => {
    new DarkMode();
  });