// assets/js/hooks.js

const Hooks = {
  UpdateTime: {
    mounted() {
      this.timer = setInterval(() => {
        const now = new Date();
        const options = {
          weekday: 'long',
          year: 'numeric',
          month: 'long',
          day: 'numeric',
          hour: '2-digit',
          minute: '2-digit',
          second: '2-digit',
          hour12: true
        };
        this.el.textContent = now.toLocaleDateString('en-US', options);
      }, 1000);
    },
    destroyed() {
      clearInterval(this.timer);
    }
  },
  
  ThemeToggle: {
    mounted() {
      this.el.addEventListener('click', () => {
        // Toggle dark mode
        if (document.documentElement.classList.contains('dark')) {
          document.documentElement.classList.remove('dark');
          localStorage.theme = 'light';
        } else {
          document.documentElement.classList.add('dark');
          localStorage.theme = 'dark';
        }
        
        // Notify LiveView about the theme change
        this.pushEvent("toggle_theme", {});
      });
      
      // Initialize based on localStorage or system preference
      if (localStorage.theme === 'dark' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        document.documentElement.classList.add('dark');
      } else {
        document.documentElement.classList.remove('dark');
      }
    }
  },
  
  TypeWriter: {
    mounted() {
      // Store the original text content
      const mainText = this.el.textContent.trim();
      // Set the initial opacity to ensure it's visible even before animation
      this.el.style.opacity = "1";
      
      // Only do the typewriter effect if not already done (to prevent issues with menu toggle)
      if (!this.el.dataset.typewriterDone) {
        this.el.textContent = ''; // Clear existing text
        let currentText = "";
        let currentIndex = 0;
        
        // Typing animation
        const typeText = () => {
          if (currentIndex < mainText.length) {
            currentText += mainText[currentIndex];
            this.el.textContent = currentText;
            currentIndex++;
            setTimeout(typeText, 50);
          } else {
            // Mark as done to prevent restart on menu toggle
            this.el.dataset.typewriterDone = "true";
            
            // Fade in navigation after typing is complete
            const navLinks = document.getElementById('main-nav');
            if (navLinks) {
              navLinks.style.opacity = "1";
              navLinks.style.transition = "opacity 1s ease";
            }
          }
        };
        
        // Start typing after a delay
        setTimeout(() => {
          typeText();
        }, 500);
      }
    }
  },
  
  FadeIn: {
    mounted() {
      // Ensure this element is always visible
      this.el.style.opacity = "1";
      
      // Only do the animation if not already done
      if (!this.el.dataset.fadeInDone) {
        // Use dataset to customize delay
        const delay = this.el.dataset.delay || 500;
        
        // Set initial state
        this.el.style.opacity = "0";
        this.el.style.transform = "translateY(10px)";
        
        setTimeout(() => {
          this.el.style.opacity = "1";
          this.el.style.transition = "opacity 0.8s ease, transform 0.8s ease";
          this.el.style.transform = "translateY(0)";
          
          // Mark as done to prevent restart on menu toggle
          this.el.dataset.fadeInDone = "true";
        }, delay);
      }
    }
  },
  
  ScrollReveal: {
    mounted() {
      // Set initial state
      this.el.style.opacity = "0";
      this.el.style.transform = "translateY(20px)";
      
      const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            // Apply custom delay if specified
            const delay = entry.target.dataset.delay || 0;
            
            setTimeout(() => {
              entry.target.style.opacity = "1";
              entry.target.style.transform = "translateY(0)";
              entry.target.style.transition = "opacity 0.8s ease, transform 0.8s ease";
            }, delay);
            
            observer.unobserve(entry.target);
          }
        });
      }, {
        threshold: 0.1,
        rootMargin: "0px 0px -100px 0px"
      });
      
      observer.observe(this.el);
    }
  },
  
  ImageHover: {
    mounted() {
      this.el.addEventListener('mouseenter', () => {
        const img = this.el.querySelector('img');
        if (img) {
          img.style.transform = 'scale(1.05)';
          img.style.transition = 'transform 0.6s ease';
        }
      });
      
      this.el.addEventListener('mouseleave', () => {
        const img = this.el.querySelector('img');
        if (img) {
          img.style.transform = 'scale(1)';
        }
      });
    }
  },
  
  FormValidation: {
    mounted() {
      const form = this.el;
      
      form.addEventListener('submit', (e) => {
        let isValid = true;
        const requiredFields = form.querySelectorAll('[required]');
        
        requiredFields.forEach(field => {
          if (!field.value.trim()) {
            isValid = false;
            field.classList.add('border-red-500');
            
            // Add error message if not already present
            const errorId = `${field.id}-error`;
            if (!document.getElementById(errorId)) {
              const errorMsg = document.createElement('p');
              errorMsg.id = errorId;
              errorMsg.className = 'text-red-500 text-xs mt-1';
              errorMsg.innerText = 'This field is required';
              field.parentNode.appendChild(errorMsg);
            }
          } else {
            field.classList.remove('border-red-500');
            
            // Remove error message if exists
            const errorId = `${field.id}-error`;
            const errorMsg = document.getElementById(errorId);
            if (errorMsg) {
              errorMsg.remove();
            }
          }
        });
        
        if (!isValid) {
          e.preventDefault();
        }
      });
      
      // Live validation as user types
      const requiredFields = form.querySelectorAll('[required]');
      requiredFields.forEach(field => {
        field.addEventListener('blur', () => {
          if (!field.value.trim()) {
            field.classList.add('border-red-500');
          } else {
            field.classList.remove('border-red-500');
            
            // Remove error message if exists
            const errorId = `${field.id}-error`;
            const errorMsg = document.getElementById(errorId);
            if (errorMsg) {
              errorMsg.remove();
            }
          }
        });
      });
      
      // Email validation
      const emailField = form.querySelector('input[type="email"]');
      if (emailField) {
        emailField.addEventListener('blur', () => {
          if (emailField.value.trim() && !isValidEmail(emailField.value.trim())) {
            emailField.classList.add('border-red-500');
            
            // Add error message if not already present
            const errorId = `${emailField.id}-error`;
            if (!document.getElementById(errorId)) {
              const errorMsg = document.createElement('p');
              errorMsg.id = errorId;
              errorMsg.className = 'text-red-500 text-xs mt-1';
              errorMsg.innerText = 'Please enter a valid email address';
              emailField.parentNode.appendChild(errorMsg);
            }
          }
        });
      }
      
      // Helper function to validate email
      function isValidEmail(email) {
        const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(email);
      }
    }
  },
  
  PageTransition: {
    mounted() {
      // Set initial state
      this.el.style.opacity = "0";
      
      // Show the element with a fade-in effect
      setTimeout(() => {
        this.el.style.opacity = "1";
        this.el.style.transition = "opacity 0.3s ease";
      }, 50);
      
      // Store scroll position when navigating away
      window.addEventListener('beforeunload', this.handleBeforeUnload = () => {
        this.pushEvent("store_scroll", { 
          path: window.location.pathname, 
          position: window.scrollY 
        });
      });
      
      // When LiveView navigates away
      window.addEventListener('phx:page-loading-start', this.handlePageLoadingStart = () => {
        // Add exit animation class
        this.el.style.opacity = "0";
      });
      
      // Cleanup handles to prevent memory leaks
      this.handleEvent("restore_scroll", ({path, position}) => {
        if (path === window.location.pathname) {
          window.scrollTo(0, position);
        }
      });
    },
    
    destroyed() {
      window.removeEventListener('beforeunload', this.handleBeforeUnload);
      window.removeEventListener('phx:page-loading-start', this.handlePageLoadingStart);
    }
  },
  
  ScrollPosition: {
    mounted() {
      // This hook is for tracking scroll positions across pages
      const path = window.location.pathname;
      
      // Use debounce to avoid too many events
      this.saveScrollPosition = debounce(() => {
        this.pushEvent("store_scroll", { 
          path: path, 
          position: window.scrollY 
        });
      }, 100);
      
      window.addEventListener('scroll', this.handleScroll = () => {
        this.saveScrollPosition();
      });
    },
    
    destroyed() {
      window.removeEventListener('scroll', this.handleScroll);
    }
  },
  
  // Add the mobile menu hook
  MobileMenu: {
    mounted() {
      // Make sure clicking the toggle button works correctly
      const toggleButtons = document.querySelectorAll('button[phx-click="toggle_menu"]');
      toggleButtons.forEach(button => {
        button.addEventListener('click', (e) => {
          // The actual toggle is handled by the LiveView event
        });
      });
      
      // Add event listener for the Escape key to close menu
      document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') {
          const menu = document.querySelector('.fixed.inset-0.bg-white.z-50, .fixed.inset-0.bg-gray-900.z-50');
          if (menu && !menu.classList.contains('pointer-events-none')) {
            // Find and click the toggle button to close the menu
            const closeButton = menu.querySelector('button[phx-click="toggle_menu"]');
            if (closeButton) {
              closeButton.click();
            }
          }
        }
      });
    }
  }
};

// Simple debounce function (used for scroll events)
function debounce(func, wait) {
  let timeout;
  return function() {
    const context = this;
    const args = arguments;
    clearTimeout(timeout);
    timeout = setTimeout(() => {
      func.apply(context, args);
    }, wait);
  };
}

export default Hooks;