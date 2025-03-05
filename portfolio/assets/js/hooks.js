// assets/js/hooks.js
const Hooks = {
  UpdateTime: {
    mounted() {
      this.updateTime();
      this.timer = setInterval(() => this.updateTime(), 1000);
    },
    updateTime() {
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
    },
    destroyed() {
      clearInterval(this.timer);
    }
  },
  
  TypeWriter: {
    mounted() {
      // Check if we've already animated on this page
      if (sessionStorage.getItem(`typewriter-${window.location.pathname}`)) {
        this.el.style.opacity = "1";
        return;
      }

      const text = this.el.textContent.trim();
      this.el.textContent = '';
      this.el.style.opacity = "1";
      
      let currentIndex = 0;
      const typeInterval = setInterval(() => {
        if (currentIndex < text.length) {
          this.el.textContent += text[currentIndex];
          currentIndex++;
        } else {
          clearInterval(typeInterval);
          // Save that we've animated this element
          sessionStorage.setItem(`typewriter-${window.location.pathname}`, 'true');
          
          // Trigger fade-in for navigation
          document.querySelectorAll('#main-nav, .fade-after-type').forEach(el => {
            el.style.opacity = "1";
            el.style.transform = "translateY(0)";
          });
        }
      }, 30);
    }
  },
  
  FadeIn: {
    mounted() {
      // Ensure we only animate on first page load
      if (sessionStorage.getItem(`fadein-${this.el.id}`)) {
        this.el.style.opacity = "1";
        this.el.style.transform = "translateY(0)";
        return;
      }
      
      // Set initial state
      this.el.style.opacity = "0";
      this.el.style.transform = "translateY(20px)";
      
      // Get delay from data attribute or use default
      const delay = this.el.dataset.delay || 300;
      
      setTimeout(() => {
        this.el.style.opacity = "1";
        this.el.style.transform = "translateY(0)";
        this.el.style.transition = "opacity 0.8s ease, transform 0.8s ease";
        
        // Mark as completed
        sessionStorage.setItem(`fadein-${this.el.id}`, 'true');
      }, delay);
    }
  },
  
  ScrollReveal: {
    mounted() {
      // Set initial state
      this.el.style.opacity = "0";
      this.el.style.transform = "translateY(30px)";
      
      const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            // Get delay from data attribute
            const delay = entry.target.dataset.delay || 150;
            
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
      const img = this.el.querySelector('img');
      if (!img) return;
      
      this.el.addEventListener('mouseenter', () => {
        img.style.transform = 'scale(1.05)';
        img.style.transition = 'transform 0.5s ease';
      });
      
      this.el.addEventListener('mouseleave', () => {
        img.style.transform = 'scale(1)';
      });
    }
  },
  
  FormValidation: {
    mounted() {
      const form = this.el;
      
      // Validate on submit
      form.addEventListener('submit', (e) => {
        if (!this.validateForm()) {
          e.preventDefault();
        }
      });
      
      // Live validation as user types
      const fields = form.querySelectorAll('input, textarea, select');
      fields.forEach(field => {
        field.addEventListener('blur', () => {
          this.validateField(field);
        });
      });
    },
    
    validateForm() {
      let isValid = true;
      const fields = this.el.querySelectorAll('input, textarea, select');
      
      fields.forEach(field => {
        if (!this.validateField(field)) {
          isValid = false;
        }
      });
      
      return isValid;
    },
    
    validateField(field) {
      // Clear existing error
      this.removeError(field);
      
      // Skip if not required and empty
      if (!field.hasAttribute('required') && !field.value.trim()) {
        return true;
      }
      
      // Required field validation
      if (field.hasAttribute('required') && !field.value.trim()) {
        this.showError(field, 'This field is required');
        return false;
      }
      
      // Email validation
      if (field.type === 'email' && field.value.trim()) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(field.value.trim())) {
          this.showError(field, 'Please enter a valid email address');
          return false;
        }
      }
      
      return true;
    },
    
    showError(field, message) {
      field.classList.add('border-red-500');
      
      const errorId = `${field.id}-error`;
      if (!document.getElementById(errorId)) {
        const errorMsg = document.createElement('p');
        errorMsg.id = errorId;
        errorMsg.className = 'text-red-500 text-xs mt-1';
        errorMsg.innerText = message;
        field.parentNode.appendChild(errorMsg);
      }
    },
    
    removeError(field) {
      field.classList.remove('border-red-500');
      
      const errorId = `${field.id}-error`;
      const errorMsg = document.getElementById(errorId);
      if (errorMsg) {
        errorMsg.remove();
      }
    }
  },
  
  PageTransition: {
    mounted() {
      // Notify the LiveView that the page is loaded
      this.pushEvent("page_loaded", {});
      
      // Set initial state and animate in
      this.el.style.opacity = "0";
      
      setTimeout(() => {
        this.el.style.opacity = "1";
        this.el.style.transition = "opacity 0.4s ease";
      }, 50);
      
      // Store scroll position before navigation
      window.addEventListener('beforeunload', this.handleBeforeUnload = () => {
        this.pushEvent("store_scroll", { 
          path: window.location.pathname, 
          position: window.scrollY 
        });
      });
      
      // Fade out when navigating away
      window.addEventListener('phx:page-loading-start', this.handlePageLoadingStart = () => {
        this.el.style.opacity = "0";
      });
    },
    
    updated() {
      // When content updates, ensure it's visible
      this.el.style.opacity = "1";
    },
    
    destroyed() {
      window.removeEventListener('beforeunload', this.handleBeforeUnload);
      window.removeEventListener('phx:page-loading-start', this.handlePageLoadingStart);
    }
  },
  
  ScrollPosition: {
    mounted() {
      // Throttle scroll events
      this.saveScrollPosition = throttle(() => {
        this.pushEvent("store_scroll", { 
          path: window.location.pathname, 
          position: window.scrollY 
        });
      }, 200);
      
      window.addEventListener('scroll', this.handleScroll = () => {
        this.saveScrollPosition();
      });
      
      // Restore scroll position if available
      const storedPosition = sessionStorage.getItem(`scroll-${window.location.pathname}`);
      if (storedPosition) {
        window.scrollTo(0, parseInt(storedPosition, 10));
      }
    },
    
    destroyed() {
      window.removeEventListener('scroll', this.handleScroll);
      
      // Save scroll position to session storage when leaving
      sessionStorage.setItem(
        `scroll-${window.location.pathname}`, 
        window.scrollY.toString()
      );
    }
  },
  
  MobileMenu: {
    mounted() {
      // Handle ESC key to close menu
      document.addEventListener('keydown', this.handleKeyDown = (e) => {
        if (e.key === 'Escape') {
          this.pushEvent("toggle_menu", {});
        }
      });
      
      // Prevent body scroll when menu is open
      const observer = new MutationObserver(() => {
        const isMenuOpen = this.el.classList.contains('opacity-100');
        document.body.style.overflow = isMenuOpen ? 'hidden' : '';
      });
      
      observer.observe(this.el, { attributes: true, attributeFilter: ['class'] });
    },
    
    destroyed() {
      document.removeEventListener('keydown', this.handleKeyDown);
      document.body.style.overflow = '';
    }
  }
};

// Utility functions
function throttle(func, wait) {
  let lastTime = 0;
  return function() {
    const now = Date.now();
    if (now - lastTime >= wait) {
      func.apply(this, arguments);
      lastTime = now;
    }
  };
}

export default Hooks;