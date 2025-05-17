/**
 * Animations and interactive elements for Brian Hall's portfolio
 * Handles scroll animations, hover effects, and dynamic content
 */

// Initialize all animations and interactive elements
function initAnimations() {
    initScrollAnimations();
    initTimeDisplay();
    initImageHoverEffects();
  }
  
  // Handle scroll-based animations
  function initScrollAnimations() {
    const sections = document.querySelectorAll('.section-fade');
    
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible');
          observer.unobserve(entry.target);
        }
      });
    }, {
      threshold: 0.1,
      rootMargin: '0px 0px -100px 0px'
    });
    
    sections.forEach(section => {
      observer.observe(section);
    });
  }
  
  // Initialize live date-time display in header
  function initTimeDisplay() {
    const datetimeElement = document.getElementById('datetime');
    if (datetimeElement) {
      updateDateTime();
      setInterval(updateDateTime, 1000);
    }
  }
  
  // Update date-time display
  function updateDateTime() {
    const datetimeElement = document.getElementById('datetime');
    if (datetimeElement) {
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
      datetimeElement.textContent = now.toLocaleDateString('en-US', options);
    }
  }
  
  // Initialize image hover effects
  function initImageHoverEffects() {
    const passionCards = document.querySelectorAll('.passion-card');
    passionCards.forEach(card => {
      const img = card.querySelector('img');
      if (img) {
        card.addEventListener('mouseenter', () => {
          img.style.transform = 'scale(1.05)';
        });
        
        card.addEventListener('mouseleave', () => {
          img.style.transform = 'scale(1)';
        });
      }
    });
  }
  
  // For mobile menu toggle functionality
  function toggleMobileMenu() {
    const mobileMenu = document.getElementById('mobile-menu');
    if (mobileMenu) {
      mobileMenu.classList.toggle('hidden');
    }
  }
  
  // Initialize everything when the document is loaded
  document.addEventListener('DOMContentLoaded', initAnimations);