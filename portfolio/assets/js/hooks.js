// assets/js/hooks.js
import { getInitialTheme, applyTheme, toggleTheme } from './theme';

const Hooks = {
  // ThemeToggle hook excerpt for hooks.js
  ThemeToggle: {
    mounted() {
      // Get current theme
      const currentTheme = localStorage.getItem('theme') || 'light';
      this.updateToggleUI(currentTheme);
      
      // Handle click to toggle theme
      this.el.addEventListener('click', () => {
        const currentTheme = localStorage.getItem('theme') || 'light';
        const newTheme = currentTheme === 'light' ? 'dark' : 'light';
        
        // Important: apply to HTML root element
        const htmlRoot = document.documentElement;
        if (newTheme === 'dark') {
          htmlRoot.classList.add('dark');
        } else {
          htmlRoot.classList.remove('dark');
        }
        
        // Store preference
        localStorage.setItem('theme', newTheme);
        
        // Update toggle UI
        this.updateToggleUI(newTheme);
        
        // Log for debugging
        console.log('Theme toggled to:', newTheme, htmlRoot.classList.contains('dark'));
        
        // Notify the server about theme change (for persisting user preference later)
        this.pushEvent('theme-changed', { theme: newTheme });
      });
    },
    
    updateToggleUI(theme) {
      // Update toggle icon/appearance based on current theme
      const darkIcon = this.el.querySelector('.dark-icon');
      const lightIcon = this.el.querySelector('.light-icon');
      
      if (theme === 'dark') {
        darkIcon.classList.remove('hidden');
        lightIcon.classList.add('hidden');
      } else {
        darkIcon.classList.add('hidden');
        lightIcon.classList.remove('hidden');
      }
    }
  },
  
  // Existing hooks with minor improvements
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
        this.el.textContent = now.toLocaleDateString('en-US', options) + " Chicago, IL";
      }, 1000);
    },
    destroyed() {
      clearInterval(this.timer);
    }
  },
  
  TypeWriter: {
    mounted() {
      const mainText = this.el.textContent.trim(); // Get text from the element
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
        this.el.style.opacity = "1";
        typeText();
      }, 1000); // Reduced delay for better UX
    }
  },
  
  FadeIn: {
    mounted() {
      // Use dataset to customize delay
      const delay = this.el.dataset.delay || (this.el.id === 'intro-text' ? 1500 : 500);
      
      setTimeout(() => {
        this.el.style.opacity = "1";
        this.el.style.transition = "opacity 0.8s ease, transform 0.8s ease";
        this.el.style.transform = "translateY(0)";
      }, delay);
      
      // Set initial state (helps with Safari)
      this.el.style.opacity = "0";
      this.el.style.transform = "translateY(10px)";
    }
  },
  
  // Enhanced and new hooks for all pages
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
  
  // Form validation hook
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
              errorMsg.className = 'text-red-500 text-xs mt-1 dark:text-red-400';
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
              errorMsg.className = 'text-red-500 text-xs mt-1 dark:text-red-400';
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
      this.el.style.opacity = "0";
      this.el.style.transition = "opacity 0.3s ease";
      // Store scroll position when leaving this page
      this.pushEvent("store_scroll", { 
        path: window.location.pathname, 
        position: window.scrollY
      });
      
      // Initialize with the "enter" animation
      this.el.classList.add('page-transition');
      this.el.classList.add('page-transition-enter');
      
      // After a small delay, trigger the active state
      setTimeout(() => {
        this.el.classList.add('page-transition-enter-active');
        this.el.classList.remove('page-transition-enter');
        this.el.style.opacity = "1";
      }, 50);
      
      // Save reference to this element for cleanup
      this.pageElement = this.el;
      
      // Add listener for LiveView navigation
      window.addEventListener('phx:page-loading-start', this.handlePageLoadingStart = () => {
        // Exit animation
        this.pageElement.classList.add('page-transition-exit');
        this.pageElement.classList.remove('page-transition-enter-active');
        this.el.style.opacity = "0";
        
        setTimeout(() => {
          this.pageElement.classList.add('page-transition-exit-active');
        }, 50);
      });
      
      // Restore scroll position when coming to this page
      this.handleEvent("restore_scroll", ({position}) => {
        window.scrollTo(0, position);
      });
    },
    
    destroyed() {
      // Clean up event listener when the element is removed
      window.removeEventListener('phx:page-loading-start', this.handlePageLoadingStart);
    }
  },
  
  ScrollPosition: {
    mounted() {
      // This hook is for tracking scroll positions across pages
      let path = window.location.pathname;
      
      // Custom debounce implementation to avoid Lodash dependency
      let debounce = (fn, delay) => {
        let timer = null;
        return function(...args) {
          if (timer) clearTimeout(timer);
          timer = setTimeout(() => {
            fn.apply(this, args);
            timer = null;
          }, delay);
        };
      };
      
      // Store scroll position on scroll
      window.addEventListener('scroll', this.handleScroll = debounce(() => {
        this.pushEvent("store_scroll", { 
          path: path, 
          position: window.scrollY 
        });
      }, 100));
    },
    
    destroyed() {
      window.removeEventListener('scroll', this.handleScroll);
    }
  },
  
  // Process page navigation
  ProcessNavigation: {
    mounted() {
      const buttons = this.el.querySelectorAll('button');
      const sections = document.querySelectorAll('.process-step');
      
      buttons.forEach(button => {
        button.addEventListener('click', () => {
          const stepId = button.dataset.step;
          
          // Update active button
          buttons.forEach(btn => {
            if (btn.dataset.step === stepId) {
              btn.classList.add('text-primary', 'dark:text-primary-dark');
              btn.classList.remove('text-gray-600', 'dark:text-gray-400');
            } else {
              btn.classList.remove('text-primary', 'dark:text-primary-dark');
              btn.classList.add('text-gray-600', 'dark:text-gray-400');
            }
          });
          
          // Show active section
          sections.forEach(section => {
            if (section.id === `step-${stepId}`) {
              section.classList.remove('hidden');
            } else {
              section.classList.add('hidden');
            }
          });
        });
      });
    }
  }
};

export default Hooks;