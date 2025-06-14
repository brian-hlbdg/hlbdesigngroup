// tms-time-component.js
// JavaScript functionality for the TMS Time Component case study page

(function() {
    'use strict';

    // Update demo times every second
    function updateDemoTimes() {
        const now = new Date();
        
        // Driver time (Pacific)
        const driverTime = new Date(now.toLocaleString("en-US", {timeZone: "America/Los_Angeles"}));
        const driverTimeElement = document.getElementById('driver-time');
        const driverDateElement = document.getElementById('driver-date');
        
        if (driverTimeElement) {
            driverTimeElement.textContent = driverTime.toLocaleTimeString('en-US', {
                hour: 'numeric',
                minute: '2-digit',
                hour12: true
            });
        }
        
        if (driverDateElement) {
            driverDateElement.textContent = driverTime.toLocaleDateString('en-US', {
                weekday: 'long',
                month: 'long',
                day: 'numeric'
            });
        }
        
        // Dispatch time (Central)
        const dispatchTime = new Date(now.toLocaleString("en-US", {timeZone: "America/Chicago"}));
        const dispatchTimeElement = document.getElementById('dispatch-time');
        const dispatchDateElement = document.getElementById('dispatch-date');
        
        if (dispatchTimeElement) {
            dispatchTimeElement.textContent = dispatchTime.toLocaleTimeString('en-US', {
                hour: 'numeric',
                minute: '2-digit',
                hour12: true
            });
        }
        
        if (dispatchDateElement) {
            dispatchDateElement.textContent = dispatchTime.toLocaleDateString('en-US', {
                weekday: 'long',
                month: 'long',
                day: 'numeric'
            });
        }
        
        // Delivery time (Eastern)
        const deliveryTime = new Date(now.toLocaleString("en-US", {timeZone: "America/New_York"}));
        const deliveryTimeElement = document.getElementById('delivery-time');
        const deliveryDateElement = document.getElementById('delivery-date');
        
        if (deliveryTimeElement) {
            deliveryTimeElement.textContent = deliveryTime.toLocaleTimeString('en-US', {
                hour: 'numeric',
                minute: '2-digit',
                hour12: true
            });
        }
        
        if (deliveryDateElement) {
            deliveryDateElement.textContent = deliveryTime.toLocaleDateString('en-US', {
                weekday: 'long',
                month: 'long',
                day: 'numeric'
            });
        }
    }
    
    // Copy code functionality
    function copyCode(elementId) {
        const codeElement = document.getElementById(elementId);
        if (!codeElement) return;
        
        const text = codeElement.textContent;
        
        navigator.clipboard.writeText(text).then(() => {
            showCopySuccess();
        }).catch(() => {
            // Fallback for older browsers
            fallbackCopyToClipboard(text);
            showCopySuccess();
        });
    }

    function showCopySuccess() {
        const button = event.target;
        const originalText = button.textContent;
        button.textContent = 'Copied!';
        button.classList.add('bg-green-600');
        
        setTimeout(() => {
            button.textContent = originalText;
            button.classList.remove('bg-green-600');
        }, 2000);
    }

    function fallbackCopyToClipboard(text) {
        const textArea = document.createElement('textarea');
        textArea.value = text;
        textArea.style.position = 'fixed';
        textArea.style.left = '-999999px';
        textArea.style.top = '-999999px';
        document.body.appendChild(textArea);
        textArea.focus();
        textArea.select();
        
        try {
            document.execCommand('copy');
        } catch (err) {
            console.error('Fallback: Oops, unable to copy', err);
        }
        
        document.body.removeChild(textArea);
    }
    
    // Smooth scrolling for anchor links
    function initSmoothScrolling() {
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    }

    // Initialize scroll animations
    function initScrollAnimations() {
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, observerOptions);

        // Observe elements for scroll animations
        document.querySelectorAll('section').forEach(section => {
            section.style.opacity = '0';
            section.style.transform = 'translateY(20px)';
            section.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
            observer.observe(section);
        });
    }

    // Mobile menu functionality
    function initMobileMenu() {
        const mobileMenuToggle = document.querySelector('[data-mobile-menu-toggle]');
        const mobileMenu = document.querySelector('[data-mobile-menu]');
        
        if (mobileMenuToggle && mobileMenu) {
            mobileMenuToggle.addEventListener('click', () => {
                mobileMenu.classList.toggle('hidden');
            });
        }
    }

    // Keyboard navigation improvements
    function initKeyboardNavigation() {
        document.addEventListener('keydown', (e) => {
            // Escape key to close any open modals or menus
            if (e.key === 'Escape') {
                const mobileMenu = document.querySelector('[data-mobile-menu]');
                if (mobileMenu && !mobileMenu.classList.contains('hidden')) {
                    mobileMenu.classList.add('hidden');
                }
            }
        });
    }

    // Focus management for accessibility
    function initFocusManagement() {
        document.querySelectorAll('a, button').forEach(element => {
            element.addEventListener('focus', function() {
                this.style.outline = '2px solid rgb(211,84,0)';
                this.style.outlineOffset = '2px';
            });
            
            element.addEventListener('blur', function() {
                this.style.outline = 'none';
            });
        });
    }

    // Print functionality
    function initPrintSupport() {
        window.addEventListener('beforeprint', () => {
            document.body.classList.add('print-mode');
        });

        window.addEventListener('afterprint', () => {
            document.body.classList.remove('print-mode');
        });
    }

    // Initialize demo time updates
    function initDemoTimeUpdates() {
        updateDemoTimes();
        setInterval(updateDemoTimes, 1000);
    }

    // Global function to make copyCode available for onclick handlers
    window.copyCode = copyCode;

    // Initialize all functionality when DOM is ready
    function init() {
        initDemoTimeUpdates();
        initSmoothScrolling();
        initScrollAnimations();
        initMobileMenu();
        initKeyboardNavigation();
        initFocusManagement();
        initPrintSupport();
    }

    // Wait for DOM to be ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }

    // Export functions for potential external use
    window.TMSTimeComponent = {
        updateDemoTimes: updateDemoTimes,
        copyCode: copyCode,
        init: init
    };

})();