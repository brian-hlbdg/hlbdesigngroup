// assets/js/dark-mode-debug.js
// Paste this into the browser console for debugging dark mode issues

(function debugDarkMode() {
    console.log('===== DARK MODE DEBUG INFO =====');
    
    // Check if the html element has dark class
    const htmlHasDarkClass = document.documentElement.classList.contains('dark');
    console.log('HTML element has dark class:', htmlHasDarkClass);
    
    // Check localStorage
    const storedTheme = localStorage.getItem('theme');
    console.log('Theme stored in localStorage:', storedTheme);
    
    // Check system preference
    const systemPrefersDark = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
    console.log('System prefers dark mode:', systemPrefersDark);
    
    // Log class list of html element
    console.log('HTML element class list:', document.documentElement.classList);
    
    // Check Tailwind config
    console.log('Checking for Tailwind dark mode styles...');
    
    // Find a few elements that should have dark mode styling
    const bodyBgStyle = window.getComputedStyle(document.body).backgroundColor;
    console.log('Body background color:', bodyBgStyle);
    
    // Check if theme toggle exists
    const themeToggle = document.getElementById('theme-toggle');
    console.log('Theme toggle exists:', !!themeToggle);
    
    // Test setting dark mode manually
    console.log('Testing manual dark mode toggle:');
    if (htmlHasDarkClass) {
      console.log('Removing dark class for testing...');
      document.documentElement.classList.remove('dark');
      console.log('Dark class removed, HTML classes now:', document.documentElement.classList);
    } else {
      console.log('Adding dark class for testing...');
      document.documentElement.classList.add('dark');
      console.log('Dark class added, HTML classes now:', document.documentElement.classList);
    }
    
    // Restore to original state
    setTimeout(() => {
      if (storedTheme === 'dark' && !htmlHasDarkClass) {
        document.documentElement.classList.add('dark');
      } else if (storedTheme === 'light' && htmlHasDarkClass) {
        document.documentElement.classList.remove('dark');
      }
      console.log('Restored to original state based on localStorage');
      console.log('===== END DARK MODE DEBUG =====');
    }, 3000);
  })();