// /csv-portfolio/assets/js/app.js

/**
 * Main application JavaScript file
 * Initializes all functionality for the portfolio site
 */

// Import modules (if using ES modules)
// import './dark-mode.js'; 
// If not using ES modules, make sure dark-mode.js is loaded before this file

/**
 * Initialize all site functionality
 */
document.addEventListener('DOMContentLoaded', () => {
    // Initialize any additional functionality
    initSmoothScroll();
    initAnimations();
    initMobileMenu();
  });
  
  /**
   * Initialize smooth scrolling for anchor links
   */
  function initSmoothScroll() {
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
      anchor.addEventListener('click', function(e) {
        e.preventDefault();
        
        const targetId = this.getAttribute('href');
        if (targetId === '#') return;
        
        const targetElement = document.querySelector(targetId);
        if (targetElement) {
          targetElement.scrollIntoView({
            behavior: 'smooth',
            block: 'start'
          });
        }
      });
    });
  }
  
  /**
   * Initialize animations for elements
   */
  function initAnimations() {
    // Use Intersection Observer to trigger animations
    const animatedElements = document.querySelectorAll('.animate-on-scroll');
    
    if (animatedElements.length > 0) {
      const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            entry.target.classList.add('animate-fade-in');
            observer.unobserve(entry.target);
          }
        });
      }, {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
      });
      
      animatedElements.forEach(element => {
        observer.observe(element);
      });
    }
  }
  
  /**
   * Initialize mobile menu functionality
   */
  function initMobileMenu() {
    const menuToggle = document.querySelector('[data-menu-toggle]');
    const mobileMenu = document.querySelector('[data-mobile-menu]');
    
    if (menuToggle && mobileMenu) {
      menuToggle.addEventListener('click', () => {
        mobileMenu.classList.toggle('hidden');
        document.body.classList.toggle('overflow-hidden');
      });
      
      // Close menu when clicking on mobile menu links
      const mobileMenuLinks = mobileMenu.querySelectorAll('a');
      mobileMenuLinks.forEach(link => {
        link.addEventListener('click', () => {
          mobileMenu.classList.add('hidden');
          document.body.classList.remove('overflow-hidden');
        });
      });
    }
  }