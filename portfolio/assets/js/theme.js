// assets/js/theme.js
// Theme handling for dark/light mode

// Check for user preference and set the theme
const getInitialTheme = () => {
    // Check for stored theme preference
    const storedTheme = localStorage.getItem('theme');
    if (storedTheme) {
      return storedTheme;
    }
    
    // Check for system preference
    if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
      return 'dark';
    }
    
    // Default to light
    return 'light';
  };
  
  // Apply theme to document - ensure it applies to HTML root element
  const applyTheme = (theme) => {
    // Important: must apply class to html element for Tailwind dark mode to work correctly
    const htmlRoot = document.documentElement;
    
    if (theme === 'dark') {
      htmlRoot.classList.add('dark');
    } else {
      htmlRoot.classList.remove('dark');
    }
    
    // Store the preference
    localStorage.setItem('theme', theme);
    
    // Log for debugging
    console.log('Theme applied:', theme, htmlRoot.classList.contains('dark'));
  };
  
  // Toggle theme function
  const toggleTheme = () => {
    const currentTheme = localStorage.getItem('theme') || 'light';
    const newTheme = currentTheme === 'light' ? 'dark' : 'light';
    applyTheme(newTheme);
    return newTheme;
  };
  
  // Initialize theme on page load
  const initTheme = () => {
    console.log('Initializing theme');
    applyTheme(getInitialTheme());
  };
  
  // Export for use in hooks
  export { getInitialTheme, applyTheme, toggleTheme, initTheme };